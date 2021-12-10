# How to run Ansible commands

## Context

We are using Ansible for more automation. At some point we will have it set up so you don't have to SSH into the server to run the command, but for now, this should help you get where you need to go.

## Steps

1. Develop your code in the [environmental-config repo](https://github.com/OHS-Hosting-Infrastructure/environment-configuration).
1. Copy the code you've written into the `/home/centos/ansible` directory on the Ansible machine (probably via scp e.g. `scp -r ansible/* centos@10.2.0.6:ansible/` where the initial argument is the location of your local changes).
1. SSH into the Ansible machine as the centos user.
1. `cd ansible` to access the ansible directory.
1. Run `ansible-playbook -i inventory <YOUR-RUNBOOK.yml> --check` to dryrun your code. Make sure it appears to work correctly.
1. You may choose to request a PR here in case you want eyes on the runbook before actually executing.
1. Run `ansible-playbook -i inventory <YOUR-RUNBOOK.yml>` to actually run the runbook.
1. Test your runbook worked as expected.
1. If you didn't request a PR before, do so now and merge your code.
