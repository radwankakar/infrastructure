# How to grant SFTP Access

1. Sign into the VPN.
1. SSH into the SFTP server.
1. `cd /home/sftpuser`
1. `sudo -s` to assume root role.
1. `cd .ssh`
1. Open `authorized_keys` file using vi or your favorite text editor.
1. Add the user's ssh-rsa token to this file.
1. `exit` the superuser role and the server.
1. Confirm with user that they now have access.
