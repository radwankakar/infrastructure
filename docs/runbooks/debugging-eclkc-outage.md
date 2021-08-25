# Debugging ECLKC During an Outage

The following are a few good steps to take when debugging an outage. Be sure to keep notes of the process in a Slack thread as you're walking through it. It's also advisable to pull another engineer into the party, something about hands and work.

* Take a look at the ECLKC-Reader-HTTPS target group to see if the Varnish servers that are under the ECLKC-Reader load balancer are marked as healthy. If a particular Varnish server is marked as unhealthy, the next step would be to ssh into that particular server.
* SSH into the Varnish servers
    * cd into `/var/log` taking note of the following directories/services:
        * `drupal`
        * `nginx`
        * `php-fpm`
        * `varnish`
    * error logs are a good place to start, as well as filtering logs by error codes i.e. 400 and 500.
    * checking the status of the above services is also recommended:
        * `sudo systemctl status [service].service`: gives you basic information on the current state of the specified service.
        * `sudo systemctl restart [service].service`: restarts the specified service. **note: restarting php will most likely drop any open connections.**
* SSH into the mariadb server, cd into `/var/lib/mysql` where the logs for the database live.