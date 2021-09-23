# Lifeboat Switchover

## Context

Lifeboat is the read-only version of the ECLKC Database that we can switch to during maintenance windows and in the case of an incident when the website is getting attacked.

Lifeboat sync jobs run every night around 11pm, so the database should be within 24 hours of up to date at all times. Before switching over, you should check that it successfully ran the night before. It generally takes about 15-20 minutes to sync the databases.

If the sync job didn't run the night before, you should default to triggering it before switching over to Lifeboat. Of course, this won't be possible if there are networking issues.

In general, if us-east is having networking issues, you should be switching over to us-west. If the database isn't working in us-east, but other things are okay, you can move to Lifeboat in east because it is a read-only copy of the previous night's database.

## How to switch to Lifeboat

1. Login to Jenkins.
1. Select the `Lifeboat-Cutover` Project.
1. From the menu bar, select `Build with Parameters`.
1. Select either `maintenance` or `failover` from the dropdown menu.
1. Click `Build`.
1. Confirm a successful build.
1. To check the host is being routed to, go to eclkc.ohs.acf.hhs.gov/gethostname.php.
    * If you’re on Varnish, you’ll have that name
    * If you’re on Lifeboat, you’ll have `lifeboat.east.eclkc`

## How to switch to ECLKC-Prod

1. To switch back over, go to the CloudFront Console in AWS.
1. Select the CloudFront Distribution with name (Description) "production"--ID `E1M2MLYJK72V3I`
1. On the `Origins` tab, select `ECLKC` Origin and select `Edit`.
1. Click `Origin domain` and select `ECLKC-Reader-1685067169.us-east-1.elb.amazonaws.com` from the drop down menu.
1. Scroll down and select `Save changes`.
1. In the `Invalidations` tab, select `Create invalidation`.
1. Add an object path of `/*` and select `Create invalidation`. The invalidation will take a minute or two to clear.
1. To check the host is being routed to, go to eclkc.ohs.acf.hhs.gov/gethostname.php.
    * If you’re on Varnish, you’ll have that name
    * If you’re on Lifeboat, you’ll have `lifeboat.east.eclkc`.
