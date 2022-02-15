# How to run Ansible commands

## Context

We are using Ansible for more automation. At some point we will have it set up so you don't have to SSH into the server to run the command, but for now, this should help you get where you need to go.

## Steps

1. Develop your code in the [environmental-config repo](https://github.com/OHS-Hosting-Infrastructure/environment-configuration).
1. Copy the code you've written into the `/home/centos/ansible` directory on the Ansible machine (probably via scp e.g. `scp -r ansible/* centos@10.2.0.6:ansible/` where the initial argument is the location of your local changes).
1. SSH into the Ansible machine as the centos user.
1. `cd ansible` to access the ansible directory.
2. Run `ansible-playbook <YOUR-RUNBOOK.yml> --check` to dryrun your code. Make sure it appears to work correctly. Some playbooks might require you to provide extra variables to run. You can tell if this is the case by taking a look at the playbook itself. In the case that you do need to provide values, you can run the playbook like so:  `ansible-playbook <YOUR-RUNBOOK.yml> --extra-vars "<VAR-1>=<value1> <VAR-2>=<value2>"`
3. Request a PR here to get eyes on the runbook before actually executing.
4. Run `ansible-playbook <YOUR-RUNBOOK.yml>` to actually run the runbook.
5. Test your runbook worked as expected. This likely means ssh'ing to the *remote host* you're configuring and verifying expected changes were made.
6. Merge your approved PR.
