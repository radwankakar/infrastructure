# Moving Jenkins Behind VPN

Design/Investigation Doc
02/02/2022
Avanti Joshi

## Context
We are moving Jenkins behind the VPN by modifying current security group rules and using an existing route53 record to access Jenkins.

Adding a security group rule to the Jenkins EC2 instance to block HTTP traffic from anywhere but the VPN will consist of 2 main changes:
 - Use an existing route53 entry and modify it to point to our Jenkins instance. Verify that this works as expected.
 - Create an HTTP security group rule that only allows access to Jenkins from the VPN’s IP.  


## Process

1) Verify existence of or add a security group rule that allows the VPN IP to access the jenkins EC2 instance.
2) Modify the existing Route53 record to point to the private IP of the EC2 instance running jenkins. 
3) Test to make sure that the Route53 record is only routable via the VPN and has permissions to access the EC2 instance. This will include ensuring that Jenkins works as expected and there aren’t any certificate or access errors. 
4) Inform teams of upcoming changes regarding accessing Jenkins. This will include:
   - Letting teams know that in the future they will have to be connected to the VPN to access jenkins
   - Sending teams new DNS name for Jenkins 
5) Create a security group in the EC2 instance for Jenkins that mirrors security groups relating to VPN access in apps such as Coaching Companion. Note that not all security group rules in Coaching Companion / ZTT etc may be needed for Jenkins. 
6) Add a security group rule to the existing Jenkins EC2 instance to only allow TCP / HTTP access from the VPN’s IP. This should block all traffic outside of the VPN to jenkins.
7) Test to make sure that the new DNS name routes properly from the browser when connected to the VPN (and does not work when connecting from the public internet). Verify other functionality as well.  


