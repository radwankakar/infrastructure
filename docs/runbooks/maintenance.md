# Maintenance

Common things to note/do during maintenance.

## Add Disk Space

1. Create a new volume from the AWS console Under Elastic Block Store > Volumes.
1. Attach the volume to the EC2 instance you are adding disk space to from the AWS console. Note: The naming convention is different between AWS and what you'll see on disk. What we've found is that on disk, `xv` corresponds to `s`. So in the console you'll see, for example, `sdf` and on disk you'll see `xvdf`.
1. SSH onto the EC2 instance you attached the new volume to and find the new device in the `/dev/` directory. Confirm the name of the disk. In our example, `sdf` is `/dev/xvdf` but you may also see a `/dev/xvdf1` if the drive already had a partition.
1. Partition the new disk device. Note: These instructions suggest `fdisk` but `parted` is a good utility to use as well.
   1. Start the `fdisk` utility by running `fdisk /dev/<DEVICE ID>`. In our example, this would be `/dev/xvdd`. You should *not* have the disk you are editing with `fdisk` mounted.
   1. `p` to print the partition table as is
   1. `n` to create a new partition.
   1. see [fdisk documentation](https://tldp.org/HOWTO/Partition/fdisk_partitioning.html) if additional formatting is needed.
1. Add a `ext4` filesystem on top. Note, you may want an xfs file system but that will use different utlities.
   1. use `mkfs.ext4` on the partition device you created.
1. Add a descriptive label to the new device to identify it. (eg. if you are creating a disk to mount to `/var/backups' label it 'backups'.)
1. Add new device mount using the label to /etc/fstab so that it will automatically mounted on a reboot. See [this linuxhint article](https://linuxhint.com/mount_partition_uuid_label_linux/ ) for further instructions.

## Update NodeJS to version 12

Check the version of node installed:

`node --version`

Clean the yum caches:

`yum clean all`

Add the NodeSource yum repo and review the script to do so [here](https://rpm.nodesource.com/setup_12.x).

`curl -sL https://rpm.nodesource.com/setup_12.x | bash -`

Check that you see new versions of node available:

`yum list available nodejs`

Remove the current version of nodejs:

`yum remove nodejs`

To install the latest available nodejs from nodesource:

`yum install nodejs`

## Updating packages on Ubuntu

Check the available versions of a package:

`apt list -a <package name>`

To install the latest version of a package available:

`apt-get install <package name>`

To install at a particular version of a package:

`apt-get install <package name>=<version>`

To clean the apt cache:

`apt-cache clean`

You may need to add a Personal Package Archive rather than from a standard repo.
See the instructions [here](https://ubiq.co/tech-blog/upgrade-apache-version-ubuntu/) for an example of using a PPA.
Be sure you trust the PPA you are using when you install from there.

## Updating pacakages on Centos

Check the available versions of a package:

`yum list available <package name>`

or

`yum --showduplicate list <package name>`

To install the latest version of a package available:

`yum install <package name>`

To install at a particular version of a package:

`apt-get install <package name-<version>.<architecture>`

To clean the yum cache:

`yum clean all`

## Cleaning up old kernels on Centos

Run the following commands on the ansible machine to hit all of our centos7 instances:

To remove all old kernels except for the last one.
`ansible centos7 -a "package-cleanup --oldkernels --count=1 -y" --become`

To check the kernels installed:

`ansible centos7 -a "yum list installed kernel" --become`
