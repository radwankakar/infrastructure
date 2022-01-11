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

## VPN debugging

If someone is unable to connect to the VPN connection figure out if it is just their configuration or a wider outage.

There are a few things to check on:

First, check if the VPN server is running in the AWS Console.
If it looks healthy there, gather some metrics over the outage window and attatch them to wherever you're tracking the outage.

Second, check if the VPN server is in a healthy state by [ssh-ing to the vpn server](#ssh-vpn-server).
If you can ssh to the server, go on ahead and start looking into files to gather information.

Third, check `/var/log/openvpn.log` (or some variation like `openvpn.log-YYMMDD`) for an error like this:

```txt
Jan  6 11:22:13 vpn openvpn: Thu Jan  6 11:22:13 2022 us=260647 73.170.220.143:54417 VERIFY ERROR: depth=0, error=CRL has expired: C=US, CN=eeeady.vpn.eclkc.info, emailAddress=eeeady@truss.works, serial=50
```

The error `error=CRL has expired:` is a dead giveaway that there is an [expired CRL](#expired-crl) on the OpenVPN server.

Otherwise, look for errors that are associated with the user having issues connecting.

### Expired CRL

A CRL is a `Client Revocation List`.
Points to note follow:

* This is an OpenSSL (and OpenVPN) file that is generated based on the certificates we sign or revoke on this server.
* This file must be kept up to date and will be regenerated on any revocation.
* When a user attempts to connect to the VPN server, the client presents the configured key and certificates. The VPN server then checks the validity of those certificates. There is a step in the validation process that checks the CRL file but if the CRL file is expired then any certificate validation with this server will fail.

TL;DR If the CRL for the server is expired, any certificate validation will fail.

To generate a new CRL for the OpenVPN server:

1. [SSH to the VPN server](#ssh-vpn-server)
1. Change to the root user.
1. Run `cd /etc/openvpn/easy-rsa`.
1. Run `source vars`.
1. Verify the CRL is expired by running `./list-crl`.
1. Check the output for the date `Next Update:`. This is when the file needs to be updated/regenerated. (Likely in the past couple days.)
1. Run `openssl ca -gencrl -keyfile keys/ca.key -cert keys/ca.crt -out keys/crl.pem -config ./openssl.cnf`.
1. Verify the CRL `Next Update:` date is in the future.

### SSH VPN server

The VPN server is configured to only accept ssh connections on the internal network so you can't just ssh to it with your usual credentials.

1. Determine your public ip address cidr.
   * Just Google "what is my ip address".
   * The CIDR is just your ip address + `/32`. (eg `127.0.0.1/32`)
1. Login to the AWS console and navigate to EC2.
1. Pull up the configuration for the OpenVPN server.
1. Under the `Security` tab, click the link to the `VPN` security group configuration.
1. On the new page, click the `Edit inbound rules` button.
1. On the modify inbound rules page, add your public ip address:
   * Click the `Add rule` at the bottom of the menu. A new rule line will pop up at the bottom of the list.
   * In the first dropdown select `SSH` and add your public ip address cidr to the source field. PLEASE add a `Description` like `eeeady debug` so this rule can be identified later.
   * Click the orange `Save rules` button at the bottom of the page.
1. From your terminal, ssh to the PUBLIC IP ADDRESS of the VPN server.
1. DELETE THE SECURITY GROUP RULE WHEN YOU ARE DONE.