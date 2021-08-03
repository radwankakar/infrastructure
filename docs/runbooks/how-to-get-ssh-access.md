# How to get SSH Access

_Note: This is temporary until we set up configuration management to manage this process._

0. Get VPN access.
1. Send a request for SSH access to the OHS Hosting team stating your team and VPN username (format: FirstinitialLastname).
2. The team will securely transmit the appropritate private key to you to allow ssh access.
   * A new OHS Hosting team member should get the centos key.
   * A new HSICC Dev team member should get the drupal key.

## Proposed process

0. Get VPN access.
1. [Generate an SSH key.](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
2. In the configuration repository (TODO: ADD LINK ONCE CREATED), create a pull request on a new branch that adds your username (match your VPN username) and your ssh public key.
3. Tag the OHS hosting team members on the PR for review and apply.
   * The OHS hosting team member will ssh to the Ansible/Nagios server in the environment. Pull the proposed changes to the configuration and execute the Ansible playbook to update the servers in the fleet.
4. Test your SSH access.
