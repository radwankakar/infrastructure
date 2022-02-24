# How to Instate Logrotate

## Context

Some of our servers are amassing logs at an alarming rate! Luckily there's a way to manage the issue of running out of space due to accumulation of logs.

This is the example for getting logrotate going in the Solr-dev server.

## What Logrotate Is

When you have a process running on a server that is set up with logging, it is constantly logging. Since you don't want to keep accruing logs indefinitely, you want to take a picture of that logfile at some point in time. This means stopping the logger from writing for a short time, moving what has been logged already to a different file that specifies the timeframe in which it was logged, then creating a new file for the logger to keep writing to.

But the process is still running while this switch is happening. So what do you do to deal with the fact that you miss the logs that accumulate during that time? There are two options:

- `copytruncate`, which means losing some data but you don't have to restart the server.
- stop the process the then restart it. This means maintaining all logs but there will be an impact to the service–and if you don't know how to do so gracefully, you should probably use `copytruncate`.

In the case of Solr-dev, this is how this works: solr.log exists. Logrotate starts, copies to everything in solr.log to solr.log.1 and creates a new, empty solr.log. We will be using `copytruncate`.

## Steps

1. `ssh` into the Solr-dev machine.

1. `cd /etc/cron.daily` and run `ls`

1. If you see that in that folder, there's a `logrotate` file already, you just need to alter the config for the specific program.

1. `cd /etc/logrotate.d/`

1. `sudo touch solr` to create a new file for the program in question.

1. `ls -lha` to confirm the new file has appropriate permissions and ownership. It should look something like this:

   ```[bash]
   -rw-r--r--.   1 root root  121 Dec 14 19:21 solr
   ```

1. `sudo vi solr` to enter the file. Enter the appropriate configuration. The first line will be the path to the logs file.

   ```[bash]
   /home/solr/eclkc-solr-nutch/solr7/solr_eclkc.log {
       su root root
       rotate 1095
       compress
       copytruncate
       daily
   }
   ```

   The rest of the information in the config file has to do with how you want the logs rotated. The first line is to tell logrotate which user/group should be used for rotation. [Read more about the directives for logrotate](https://linux.die.net/man/8/logrotate). In this case we've specified that there should be 1095 log files (365\*3 for 3 years according to gov directive) until they begin getting deleted. We want the files compressed. We want to use copytruncate (explained above), and we want these to run daily.

1. Once you're content with the config, run `sudo logrotate --force /etc/logrotate.conf` from anywhere. This should force the rotation to occur.

1. Check the rotation worked by visiting `sudo ls -lha /home/solr/eclkc-solr-nutch/solr7` and confirming there is a zipped log with the day's date for solr (i.e. `solr_eclkc.log-20211214.gz`).

1. Follow up the next day by checking the same location. You should see a new log there for the following day (in this case  `solr_eclkc.log-20211215.gz`).

### References

[logrotate directives](https://linux.die.net/man/8/logrotate)

[solr example](https://www.sysarchitects.com/logrotate_for_solr)

[info about solr logrotate use](https://docs.bitnami.com/ibm/infrastructure/solr/administration/configure-use-logrotate/)

[why you don't have to use both daily and size](https://serverfault.com/questions/391538/logrotate-daily-and-size)
