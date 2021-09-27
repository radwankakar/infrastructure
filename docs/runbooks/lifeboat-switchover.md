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
1. To check the host that is being routed to, go to eclkc.ohs.acf.hhs.gov/gethostname.php.
    * If you’re on Varnish, you’ll have that name
    * If you’re on Lifeboat for maintenance, you’ll have `lifeboat.east.eclkc`
    * If you’re on Lifeboat for failover, you’ll have `lifeboat.west.eclkc`

## How to switch to ECLKC-Prod

1. 1. Login to Jenkins.
1. Select the `ECLKC-Prod-Cutover` Project.
1. From the menu bar, select `Build Now`.
1. Confirm a successful build.
1. To check the host that is being routed to, go to eclkc.ohs.acf.hhs.gov/gethostname.php.
    * If you’re on Varnish, you’ll have that name
    * If you’re on Lifeboat for maintenance, you’ll have `lifeboat.east.eclkc`
    * If you’re on Lifeboat for failover, you’ll have `lifeboat.west.eclkc`
