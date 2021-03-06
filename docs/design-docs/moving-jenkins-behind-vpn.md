# Moving Jenkins Behind VPN

Design Doc

02/02/2022

Avanti Joshi

## Context

We are moving Jenkins behind the VPN by modifying current security group rules and using an existing Route53 record to access Jenkins.

Adding a security group rule to the Jenkins EC2 instance to block HTTP traffic from anywhere but the VPN will consist of 2 main changes:

- Use the existing Route53 '.east' entry that routes via the VPN and modify it to point to the private IP of our Jenkins EC2 instance. Verify that this works as expected.
- Create an HTTP security group rule that only allows access to Jenkins from the VPN’s IP.

## Process

1. Verify existence of or add a security group rule that allows the VPN IP to access the Jenkins EC2 instance.
1. Modify the existing Route53 record to point to the private IP of the EC2 instance running Jenkins.
1. Test to make sure that the Route53 record name is only routable via the VPN and has permissions to access the EC2 instance. This will include ensuring that Jenkins works as expected and there aren’t any certificate or access errors.
1. Inform teams of upcoming changes regarding accessing Jenkins. This will include:
   - Letting teams know that in the future they will have to be connected to the VPN to access Jenkins
   - Sending teams new DNS name for Jenkins
   - Checking to see if any teams have incoming webhooks into Jenkins configured that could be affected by moving Jenkins behind the VPN. We know there is interaction between GitHub, BitBucket and Box with Jenkins. We will need to investigate whether these are inbound or outbound. Research on external services that need access can be found [here](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/research/jenkins-external-services.md).
   - Asking teams to see if additional VPN access will need to be granted for members who need to use Jenkins
1. Remove the security group rule that currently allows HTTP access externally from the public internet.
1. Test to make sure that the new DNS name routes properly from the browser when connected to the VPN (and does not work when connecting from the public internet). Verify that there are no issus with Github, BitBucket, and Box accessing Jenkins along with other functionality as well.
