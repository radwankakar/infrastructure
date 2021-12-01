# Restore DB on the ec2 MariaDB

We have a shared MariaDB database on an ec2 instance.
We are currently weighing the pros/cons of migrating to RDS so hopefully these instructions will not be necessary for very long.

The last 7 days of backup files are stored in `/var/backups` on the MariaDB instance and are organized by date.
The backup job also stores the backup data in s3://eclkc-backups.

The files in the date folders are encrypted duplicity files.
Duplicity is a file backup management application for linux and can be used for more than encryption but also for syncing and managing diffs.
The duplicity application is not responsible for syncing remotely in this case.
The backups script uses a gpg key to encrypt the files, to perform any restores, you will need the passphrase for the key.
The passphrase is stored in AWS SSM Parameter store under the path `/ohs-hosting/misc/mysql-backup-gpg-pw`.

_Note: These commands have not been tested for anything past the last 7 days.
To restore from before 7 days ago, you will have to sync data from s3 then attempt a duplicity restore of the sql files._

## Duplicity restore

To see full list of options you can check out:

- [Ubuntu Duplity backup how to](https://help.ubuntu.com/community/DuplicityBackupHowto)
- [Duplicity docs](http://duplicity.nongnu.org/docs.html)

To regenerate all of the files from a date:

```sh
duplicity file://[PATH TO BACKUP DIRECTORY]
```

For example, to regenerate files from July 30, 2021 to the directory `/var/backups/tmp/full` you would run:

```sh
duplicity file:///var/backups/2021-07-30/mysql-full-2021-07-30T23\:40\:01 /var/backups/tmp/full
```

This command will ask you for the passphrase for gpg.
This is stored as gpg-mysql in the keepass file.

## General Mysql DB backup/restore commands

To back up a specific database before running a backup:

```sh
mysqldump [DATABASE NAME] > [BACKUP FILE NAME].sql
```

To restore a specific database from file:

```sh
mysql [DATABASE NAME] < [BACKUP FILE NAME].sql
```

For example, to restore the `coaching_companion` database to the state it was as of this backup file using a file restored from Duplicity:

```sh
mysql coaching_companion < mariadb.east.eclkc-coaching_companion-mysql-bin.099547-111767540.sql
```
