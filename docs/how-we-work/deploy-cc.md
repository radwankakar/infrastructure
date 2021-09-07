# Deploying Coaching Companion

## Context

One day, all of our deployments will be automated. Until then, they are nasty as heck.
Here's what you do if you need to deploy the Coaching Companion site.

### Staging

Staging deployment is mostly automated.

When Dayton pushes to the[Coaching Companion GitHub repo](https://github.com/HSICC/OHSCC) this triggers a Jenkins job called "GitHub-OHSCC".
This job stashes any local changes on the `coachingcompanion-dev` machine and then runs a git pull.

If this job fails, you will usually need to ssh to the Coaching Companion dev server and do a hard reset:

1. `ssh -i path_to_your_key centos@private_ip`
1. `cd /var/www/ohscc/cc`
1. `sudo -u cc git reset --hard origin/master`

The Jenkins job may show other errors which you will need to manually diagnose and resolve.
Please note these issues and resolution here:

#### Username/password authentication instead of token for github

Example error:

```txt
Failed to connect to repository : Command "git ls-remote -h -- https://github.com/HSICC/OHSCC HEAD" returned status code 128:
stdout:
stderr: remote: Support for password authentication was removed on August 13, 2021. Please use a personal access token instead.
remote: Please see https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information.
fatal: unable to access 'https://github.com/HSICC/OHSCC/': The requested URL returned error: 403
```

In the Jenkins job configuration, scroll down to the section labelled "Source Code Management".
You will see the repository configuration with the URL and the Credentials to use.
Jenkins has several different credentials configured, you should select something from the dropdown that has been configured to pull from the HSICC repos like "eclkcgithub/***".

### Prod

Confirm with UofW administrator Dayton Alleman that he has pushed his desired changes to master branch in the [Coaching Companion GitHub repo](https://github.com/HSICC/OHSCC). Logon to the VPN and SSH into the prod machine (you can find Private IP on AWS, currently called CoachingCompanion). The code is currently running from  `/var/www/ohscc/cc` NOT `/home/centos/cc`. You can check by running `git log` to ensure you have a recent pull. You will need to use the `cc` user rather than the `centos` user to run the pull, so the command currently is `sudo -u cc git pull`.

1. `ssh -i path_to_your_key centos@private_ip`
1. `cd /var/www/ohscc/cc`
1. `sudo -u cc git pull`

Once you've completed, check that the update has worked by reviewing the fix [on the site](https://eclkc.ohs.acf.hhs.gov/cc) or by comparing the code on the CoachingCompanion box to the [master branch in their repo](https://github.com/HSICC/OHSCC).
