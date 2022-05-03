# How to support the eclkc drupal deployment

## Notes

- This should be automated such that Sam can do this himself.
- Varnish targets always use port `80`.

## Pre-Deployment steps

The HSICC team (usually Scott) will send a calendar invite for the Drupal deployment window to the content team and the team performing the deployment.

At the beginning of the deployment window, confirm with HSICC that user submissions and job center have been disabled.

### Sync the latest application data to lifeboat

1. Log into Jenkins.
1. Run the [Pre Drupal Deploy Lifeboat sync](https://jenkins.eclkc.info/job/Pre%20Drupal%20Deploy%20Lifeboat%20sync/).
   _For reference: This job triggers a DB export of production and imports it into the lifeboat db in us-east. It then syncs any site files from varnish1 to the lifeboat server._
1. Once the `Pre Drupal Deploy Lifeboat sync` job completes successfully, connect to vpn east and test Lifeboat by going to [ip address](http://10.0.0.23) of the lifeboat server in your browser.
   _Just make sure the page loads and you can click to a few different pages._

Lifeboat is now up to date with production.

### Schedule a Pagerduty Override

1. Log into Pagerduty
2. Go to the [Pagerduty schedules](https://headstarthosting.pagerduty.com/schedules) page and select the Gear on the Infrasec - Primary schedule.
3. Select "Schedule an Override" and enter in your information for the period of the Drupal Deploy.

### Route traffic to Lifeboat only for Drupal

1. Update the Varnish configuration on Varnish1 to point Drupal traffic to Lifeboat.

   1. On the Varnish1 server open the file `/etc/varnish/default.vcl` for editing with the command: `sudo vim /etc/varnish/default.vcl`.
   1. Edit the `default` backend definition from:

   ```txt
   backend default {
       .host = "127.0.0.1";
       .port = "81";
       #.host = "10.0.0.23"; # lifeboat
       #.port = "80"; # lifeboat
   }
   ```

   to

   ```txt
   backend default {
       #.host = "127.0.0.1";
       #.port = "81";
       .host = "10.0.0.23"; # lifeboat
       .port = "80"; # lifeboat
   }
   ```

1. Cycle the Varnish servers in the production loadbalancer target group.

   1. Log into the AWS console.
   1. Deregister Varnish1 from the [production loadbalancer target group][1] to drain the connections.
   1. SSH to Varnish1 and restart the Varnish service with the following command: `sudo systemctl restart varnish`.
   1. Register the Varnish1 target back to the [production loadbalancer target group][1]. Wait until the status is `Healthy`. If the status doesn't come up as `Healthy`, there may be an issue you can debug using our [maintenance](maintenance.md) or [debugging outages](debugging-outages.md) docs.
   1. Wait for Varnish1 to be healthy and deregister Varnish2 from the [production loadbalancer target group][1]. _Note: We do not change the Varnish2 configuration because HSICC uses it to verify their deployment._

1. Verify that users are directed to Lifeboat by checking the active server hostname [here](https://eclkc.ohs.acf.hhs.gov/gethostname.php).

1. Notify the HSICC team can begin their deployment.

## Drupal deployment

- The HSICC team manages their own code deployment.
- Provide troubleshooting support if necessary.
- They test on [drupal8prod](https://drupal8prod.eclkc.info/).

## Post Drupal deployment

Once the HSICC team confirms their deployment was successful reroute traffic to the production Drupal servers.

### Reroute Varnish traffic back to production

1. Register Varnish2 back to [production loadbalancer target group][1]. Wait until the status is `Healthy`.

1. Deregister Varnish1 from the [production loadbalancer target group][1] to drain the connections.

1. Revert the Varnish configuration on Varnish1.

   1. On the Varnish1 server open the file `/etc/varnish/default.vcl` for editing with the command: `sudo vim /etc/varnish/default.vcl`.
   1. Edit the `default` backend definition from:

   ```txt
   backend default {
       #.host = "127.0.0.1";
       #.port = "81";
       .host = "10.0.0.23"; # lifeboat
       .port = "80"; # lifeboat
   }
   ```

   to

   ```txt
   backend default {
       .host = "127.0.0.1";
       .port = "81";
       #.host = "10.0.0.23"; # lifeboat
       #.port = "80"; # lifeboat
   }
   ```

1. SSH to Varnish1 and restart the Varnish service with the following command: `sudo systemctl restart varnish`.

1. Reregister Varnish1 back to the [production loadbalancer target group][1]. Wait until the status is `Healthy`.

1. Notify HSICC that traffic is routed to production.

1. Trigger an update to 404.html pages on Varnish1 and Varnish2 by ssh'ing into each server and running the script in /etc/varnish/update-404.sh on those machines.

[1]: https://console.aws.amazon.com/ec2/home?region=us-east-1#TargetGroup:targetGroupArn=arn:aws:elasticloadbalancing:us-east-1:802093990117:targetgroup/ECLKC-Reader-HTTPS/203a044ad376dddf
