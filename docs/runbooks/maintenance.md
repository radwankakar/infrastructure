# Maintenance

Common things to note/do during maintenance.

## Table of Contents

<!-- mdformat-toc start --slug=github --no-anchors --maxlevel=6 --minlevel=1 -->

- [Maintenance](#maintenance)
  - [Table of Contents](#table-of-contents)
  - [Create a new volume](#create-a-new-volume)
  - [Attach a volume to an EC2 instance](#attach-a-volume-to-an-ec2-instance)
  - [Add Disk Space](#add-disk-space)
  - [Examine and partition a new disk](#examine-and-partition-a-new-disk)
  - [Mount a disk](#mount-a-disk)
  - [Unmount a disk](#unmount-a-disk)
  - [Add a label to a disk](#add-a-label-to-a-disk)
  - [Sync the backup](#sync-the-backup)
  - [Update NodeJS to version 12](#update-nodejs-to-version-12)
  - [Updating packages on Ubuntu](#updating-packages-on-ubuntu)
  - [Updating packages on Centos](#updating-packages-on-centos)
    - [Updating PHP on Centos](#updating-php-on-centos)
  - [Updating failures](#updating-failures)
  - [Cleaning up old kernels on Centos](#cleaning-up-old-kernels-on-centos)

<!-- mdformat-toc end -->

## Create a new volume

If you want it to expand disk space on a currently extant volume:

1. Determine which volume to copy.
   1. SSH into the EC2 instance where you'll be adding the disk space.
   1. Run `fd -h` to examine the filesystems and where they are mounted. Select the volume that is mounted where you want a duplication. **Note**: The naming convention is different between AWS and what you'll see on disk. What we've found is that on disk, `xv` corresponds to `s`. So in the console when looking at the Volume's `Attachment information` you'll see the EC2 instance and a name (for example, `sdf1`) while on disk you'll see that name represented as `/dev/xvdf1`.
1. Now that you know which volume to copy, select that volume from the AWS EC2 console under Elastic Block Store > Volumes. Select the `Actions` dropdown and choose `Create Snapshot`. It will take a while to create and appear under `Snapshots`.
1. Create a volume from the snapshot from the AWS EC2 console under Elastic Block Store > Snapshots by selecting your recently created snapshot. Select the `Actions` dropdown and choose `Create Volume`. Make sure you choose an appropriately large size (greater than the size of the volume you're copying if you are increasing disk space). Note, you cannot downsize a volume from a snapshot.

If you aren't creating a volume based on one that already exists:

1. Create a new volume from the AWS EC2 console under Elastic Block Store > Volumes by selecting `Create Volume`. Make sure you choose an appropriately large size if you are increasing disk space.

## Attach a volume to an EC2 instance

Attach the volume to the EC2 instance you are adding disk space to from the AWS EC2 console under Elastic Block Store > Volumes by selecting the `Actions` dropdown and choosing `Attach Volume`.
**Note**: The naming convention is different  between AWS and what you'll see on disk. What we've found is that on disk, `xv` corresponds to `s`. So in the console when looking at the Volume's `Attachment information` you'll see the EC2 instance and a name (for example, `sdf`) while on disk you'll see that name represented as `/dev/xvdf`.

1. SSH onto the EC2 instance you attached the new volume to and find the new device in the `/dev/` directory. Confirm the name of the disk. In our example, `sdf` is `/dev/xvdf` but you may also see a `/dev/xvdf1` if the drive already had a partition.

## Add Disk Space

1. [Create a new volume](#create-a-new-volume)

1. Once you have created the volume, [attach the volume to the EC2 instance](#attach-a-volume-to-an-ec2-instance) you are adding disk space to.

1. Then [examine and partition the new disk](#examine-and-partition-a-new-disk)

1. [Mount the disk](#mount-a-disk)  (if unmounted) to determine whether you need to add a filesystem.

   1. If you have an issue with the file type, you can repair by running the following on an unmounted disk: `[sudo] xfs_repair /dev/<DEVICE_ID><partition>`. (You may have to run `[sudo] xfs_repair -L /dev/<DEVICE_ID><partition>` instead).
   1. If the mounted disk does not show the correct size after you mount it (examine by running `df -h`), run `[sudo] xfs_growfs /var/<MOUNT>`. Run `df -h` again to confirm it is the correct size.

1. Add a `ext4` filesystem on top. Note, you may want an xfs file system but that will use different utlities.

   1. use `mkfs.ext4` on the partition device you created.

1. [Add a label to a disk](#add-a-label-to-a-disk) to give it a human-readable identifier.

1. If you're switching a volume for a copy of a larger size:

   1. [Sync the backup](#sync-a-backup) then [unmount](#unmount-a-disk) both the current volume and replacement volume.
   1. Then [mount the replacement volume](#mount-a-disk) to the original mount path in the filesystem.
   1. Delete the disk you've been using for the swap out but NOT the disk you want to maintain.

1. Add new device mount /etc/fstab so that it will automatically mounted on a reboot. Run `[sudo] vi /etc/fstab` to edit fstab. Replace the volume name with the new volume that has been mounted on disk. If you're switching the volume, remove the line referencing the swap mount you had been using. See [this linuxhint article](https://linuxhint.com/mount_partition_uuid_label_linux/) if you need further instructions.

1. Run `[sudo] mount -av` to reload from fstab.

1. Confirm your work by running `df -h`.

## Examine and partition a new disk

1. Examine the new disk device and partition it. Note: These instructions suggest `fdisk` but `parted` is a good utility to use as well. With `fdisk`, the `Start` and `End` bytes will indicate the size of the partition you're viewing.
   1. Start the `fdisk` utility by running `[sudo] fdisk /dev/<DEVICE ID>`. In our example, this would be `/dev/xvdd`. You should *not* have the disk you are editing with `fdisk` mounted.
   1. `p` to print the partition table as is.
   1. `d` to delete the partition (in the case where you need to resize the partition--i.e. if the partition that's created by default isn't big enough).
   1. `n` to create a new partition. If you want it to take up the whole disk (which likely you do), select the default options by hitting `enter`/`return` 4 times: `p` for primary Partition type, `1` for Partition number, `2048` for First Sector, `1048575999` for Last sector.
   1. `w` to save your new partition and exit.
   1. `q` to quit fdisk.
   1. see [fdisk documentation](https://tldp.org/HOWTO/Partition/fdisk_partitioning.html) if additional formatting is needed.

## Mount a disk

1. `cd /var/`

1. Make a directory to mount the disk to: `mkdir <MOUNT>`

1. `[sudo] mount -t <filesystem> /dev/<DEVICE_ID> <MOUNT>`

   **Notes:**

   - To determine filesystem, you can run `df -Th`.
   - If you have copied the volume from another volume via snapshot, you will have to change the filesystem UUID.
     1. `[sudo] xfs_admin -U <NEW_UUID> /dev/<DEVICE_ID>`. You can just change a few of the characters in the currently existing UUID and then mount.

## Unmount a disk

1. `[sudo] umount -t <filesystem> <DEVICE_ID> <MOUNT>`

## Add a label to a disk

Add a label to the new device to identify it (eg. if you are creating a disk to mount to `/var/backups`, label it 'Backups'.

1. `[sudo] xfs_admin -L Backups /dev/<DEVICE_ID>`.)

## Sync the backup

1. If you'll be switching out a disk, you'll want to sync the disk you'll be switching to the disk you'll be switching from.
1. `[sudo] rsync -vrau --delete <SOURCE_DIR>/ <DESTINATION_DIR>`. MAKE SURE YOU INCLUDE the `/` after the source directory! (Could also be phrased as `[sudo] rsync -vrau --delete <OLD_MOUNT>/ <NEW_MOUNT>`.)

## Update NodeJS to version 12

Check the version of node installed:

`node --version`

Clean the yum caches:

`yum clean all`

Add the NodeSource yum repo and review the script to do so [here](https://rpm.nodesource.com/setup_12.x).

`curl -sL https://rpm.nodesource.com/setup_12.x | bash -`

Check that you see new versions of node available:

`yum list available nodejs`

Remove the current version of nodejs:

`yum remove nodejs`

To install the latest available nodejs from nodesource:

`yum install nodejs`

## Updating packages on Ubuntu

Check the available versions of a package:

`apt list -a <package name>`

To install the latest version of a package available:

`apt-get install <package name>`

To install at a particular version of a package:

`apt-get install <package name>=<version>`

To clean the apt cache:

`apt-cache clean`

You may need to add a Personal Package Archive rather than from a standard repo.
See the instructions [here](https://ubiq.co/tech-blog/upgrade-apache-version-ubuntu/) for an example of using a PPA.
Be sure you trust the PPA you are using when you install from there.

## Updating packages on Centos

Check the available versions of a package:

`yum list available <package name>`

or

`yum --showduplicate list <package name>`

To install the latest version of a package available:

`yum install <package name>`

To install at a particular version of a package:

`apt-get install <package name-<version>.<architecture>`

To clean the yum cache:

`yum clean all`

### Updating PHP on Centos

1. Check the php version:

   `php -v`

1. Check to see what php related packages you have (save this list):

   `yum list installed | grep php`

1. You should be updating PHP from the ius repo, not the remi repo. Install the repo if it's not already on the box:

   `yum install https://centos7.iuscommunity.org/ius-release.rpm`
   or
   `wget https://repo.ius.io/ius-release-el7.rpm`

Before replacing the php version, save backups of `/etc/php.ini` and`/etc/php-fpm.d/www.conf`.

1. Replace the php version you're using with the one you want (replace XX with the version i.e. v8.2 becomes php82):

   `sudo yum install phpXX` or `sudo yum install phpXX-common`.

1. Then install all the packages you identified in the grep step. Will look like:

   `sudo yum install php74 php74-fpm-nginx php74-fpm php74-gd php74-cli` etc.

   If you get an error that there's a conflict, you will need to remove the current package (replace XX with the version i.e. v8.2 becomes php82u) before doing the  install steps above, copy the current php config:

   `cd /etc/php-fpm.d`
   `cp www.conf www.conf.backup`

   Then remove the current version:

   `sudo yum remove phpXX` or `sudo yum remove phpXX-common`.

   And continue from step 4. After you've done the installation, replace the newly generated `www.conf` with the backup you saved:

   ```console
   mv www.conf www.conf.default
   mv www.conf.backup www.conf
   rm www.conf.default
   ```

   Add back the php configuration from the backups you saved previously.

1. Restart various services:

   `service httpd restart`
   `sudo systemctl restart php-fpm.service`
   `sudo systemctl restart nginx.service`.

1. Check the environment that you've replaced the php version in. Make sure to check not just the home page.
   In the case that you are getting a 502 or other error, run the following to look at the logs:

   `sudo tail -f /var/log/nginx/error.log`

1. If you have an issue where you're seeing something like `unix:/run/php-fpm/www.sock failed (2: No such file or directory) while connecting to upstream` or `unix:/run/php-fpm/www.sock failed (13: Permission denied) while connecting to upstream`, it's an issue with the socket. Debug using our [documentation](debugging-outages.md).

1. You may need to also update the memory_limit in the /etc/php.ini file as well to 1024M for deployment jobs to complete successfully.

The php-fpm service may not be automatically enabled so when the server restarts php-fpm will not automatically be started.
To fix this run:

`sudo systemctl enable php-fpm.service`

## Updating failures

Sometimes when running the [`update-dev` ansible playbook](https://github.com/OHS-Hosting-Infrastructure/environment-configuration/blob/main/docs/runbooks/how-to-monthly-maintenance.md#update-os-packages-on-dev-and-staging), you'll get a failure. The error may look like this:

```sh
"Error: Package: 1:v8-devel-3.14.5.10-25.el7.x86_64 (@epel)
           Requires: v8 = 1:3.14.5.10-25.el7
           Removing: 1:v8-3.14.5.10-25.el7.x86_64 (@epel)
               v8 = 1:3.14.5.10-25.el7
           Obsoleted By: 1:nodejs-libs-16.13.2-7.el7.x86_64 (epel)
               v8 = 2:9.4.146.24-7.el7
```

In those cases, it may help to find package blocking the update (in the above case, v8) and to SSH onto the individual machines, uninstall the package and reinstall.

```sh
yum info v8
sudo yum remove v8
sudo yum install v8
yum info v8
```

This is acknowledged bad behavior. It is a bandaid solution for now.

## Cleaning up old kernels on Centos

Run the following commands on the ansible machine to hit all of our centos7 instances:

To remove all old kernels except for the last one.
Note, run this after reboots on ansible-nagios and vpn because those instances will still be using the old kernels.
`ansible centos7 -a "package-cleanup --oldkernels --count=1 -y" --become`

To check the kernels installed:

`ansible centos7 -a "yum list installed kernel" --become`
