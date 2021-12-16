# Debugging Outages

The following are a few good steps to take when debugging an outage. Be sure to keep notes of the process in a Slack thread as you're walking through it. It's also advisable to pull another engineer into the party, something about hands and work.

* Take a look at the ECLKC-Reader-HTTPS target group to see if the Varnish servers that are under the ECLKC-Reader load balancer are marked as healthy. If a particular Varnish server is marked as unhealthy, the next step would be to ssh into that particular server.
* SSH into the Varnish servers
  * cd into `/var/log` taking note of the following directories/services:
    * `drupal`
    * `nginx`
    * `php-fpm`
    * `varnish`
  * using the `less` command to open the error logs is a good place to start, as well as filtering/searching through the logs by error codes i.e. 400 and 500.
    * checking the status of the above services is also recommended:
      * `sudo systemctl status [service].service`: gives you basic information on the current state of the specified service.
      * `sudo systemctl restart [service].service`: restarts the specified service. **note: restarting php will most likely drop any open connections.**
* If the errors found in the Varnish servers point to a database issue, or if for some reason it proves to be a dead end, SSH into the mariadb server, and cd into `/var/lib/mysql` where the logs for the database live.
  * there you will find `mariadb-error.log`. Using the `less` command you can take a look through. Looking for anything particularly odd. Such as repeated failed attempts to accomplish a job, the same job called many times in succession, an aborted connection to a particular host, among other things.

## Common Nagios Alerts

### Many alerts from same server

This is likely indicative of the server being completely down/inaccessible or the Nagios agent on the server is broken.

Example:
You see multiple emails from nagios that look like the following.

```txt
** PROBLEM Service Alert: cc-dev.east.eclkc/Total Processes is CRITICAL **
** PROBLEM Service Alert: cc-dev.east.eclkc/Uptime is CRITICAL **
** PROBLEM Service Alert: cc-dev.east.eclkc/Zombie Processes is CRITICAL **
** PROBLEM Service Alert: cc-dev.east.eclkc/CPU Load is CRITICAL **
** PROBLEM Service Alert: cc-dev.east.eclkc/Disk Check is CRITICAL **
** PROBLEM Service Alert: cc-dev.east.eclkc/Current Users is CRITICAL **
** PROBLEM Service Alert: cc-dev.east.eclkc/Memory Usage is CRITICAL **
```

There are a couple possibilities for the issue:

* The named server is down or inacessible through the network.
  1. Verify the server is up from the AWS console. - If it is not on, turn it on.
  1. Verify you can access the server via SSH. - If you cannot, check security groups, network information, and your login.
  1. If none of the above apply, check the next bullet point.
* The Nagios agent on the named server has failed and stopped reporting data to the main server.
  1. SSH to the named server.
  1. Check if the Nagios agent is running. Check with: `sudo systemctl status nrpe`.
  1. If the agent is not running, restart it with: `sudo systemctl restart nrpe`.
  1. If the agent does not start, you will need to debug further.
