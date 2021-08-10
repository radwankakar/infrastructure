# Deploying Coaching Companion

## Context

One day, all of our deployments will be automated. Until then, they are nasty as heck.
Here's what you do if you need to deploy the Coaching Companion site.

### Staging

To come.

### Prod

Confirm with UofW administrator Dayton Alleman that he has pushed his desired changes to master branch in the [Coaching Companion GitHub repo](https://github.com/HSICC/OHSCC). Logon to the VPN and SSH into the prod machine (you can find Private IP on AWS, currently called CoachingCompanion). The code is currently running from  `/var/www/ohscc/cc` NOT `/home/centos/cc`. You can check by running `git log` to ensure you have a recent pull. You will need to use the `cc` user rather than the `centos` user to run the pull, so the command currently is `sudo -u cc git pull`. 

1. `ssh -i path_to_your_key centos@private_ip`
1. `cd /var/www/ohscc/cc`
1. `sudo -u cc git pull`

Once you've completed, check that the update has worked by reviewing the fix [on the site](https://eclkc.ohs.acf.hhs.gov/cc) or by comparing the code on the CoachingCompanion box to the [master branch in their repo](https://github.com/HSICC/OHSCC).
