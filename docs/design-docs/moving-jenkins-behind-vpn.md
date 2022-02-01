# OHS: Move Jenkins Behind VPN
Technical Story: [Develop Plan to Move Jenkins behind VPN](https://ocio-jira.acf.hhs.gov/browse/OHSH-354)
Design Doc  
02/01/2022 

## Context and Problem Statement

Currently Jenkins is available through the public internet. While there are controls to prevent unauthorized access, it's still not best practice to continue this since Jenkins also has access to the production environments. We are also blocked on using Jenkins for automation during deployments due to the security risks the current setup poses.

We need to move the Jenkins machine behind the VPN so that the Jenkins login page can only be accessed when connected to the VPN.

## Decision Drivers 
- Reduce technical toil
- Automate currently manual tasks

## Considered Options

### Change security group rules
One proposed solution is to change the security group rule(s) of our currently deployed Jenkins instance. We could add a security group rule that only allows a connection from the VPN and blocks all other traffic. 

### Redeploy Jenkins instance
The second proposed solution is to redeploy Jenkins within a private subnet that the VPN can access. This change would include: deploying a new instance of Jenkins in a private subnet that the VPN can access, communicating with OHS teams using Jenkins to not make any changes in the old instance, and transferring jobs over to the newly deployed instance batch by batch. 

## Pros and Cons of the Options

Change security group rules
- Good, doesn’t require Jenkins redeploy
- Good, lower lift to implement / can be implemented relatively quickly
- Bad, This could result in some downtime for jenkins if there are any issues with the connection rules / implementing this change.
- Bad, Jenkins would still be in public subset


Redeploy Jenkins instance
- Good, Jenkins would be in private subnet
- Bad, Jenkins redeploy required
- Bad, would require communication to OHS teams 


## Decision Outcome
Chosen option: change security groups rules. 
Adding a security group rule to the Jenkins EC2 instance to block HTTP traffic from anywhere but the VPN will consist of 2 main changes:
 Use an existing route53 entry and modify it to point to our Jenkins instance. Verify that this works as expected.
Create an HTTP security group rule that only allows access to Jenkins from the VPN’s IP.  

A more detailed step by step breakdown of the process is below. 
Steps To Move Jenkins Behind the VPN:

1) Verify existence of or add a security group rule that allows the VPN IP to access the jenkins EC2 instance.
2) Modify the existing ‘jenkins.ecklc.east’ Route53 record to point to the private IP of the EC2 instance running jenkins. 
3) Test to make sure that ‘jenkins.ecklc.east’ is only routable via the VPN and has permissions to access the EC2 instance. This will include ensuring that Jenkins works as expected and there aren’t any certificate or access errors. 
4) Inform teams of upcoming changes regarding accessing Jenkins. This will include:
- Letting teams know that in the future they will have to be connected to the vpn to access jenkins
- The new DNS name for Jenkins 
5) Create a security group in the EC2 instance for Jenkins that mirrors security groups relating to VPN access in apps such as Coaching Companion. Note that not all security group rules needed in Coaching Companion / ZTT etc may be needed in our case. 
6) Add a security group rule to the existing Jenkins EC2 instance to only allow TCP / HTTP access from the VPN’s IP. This should block all traffic outside of the VPN to jenkins.
7) Test to make sure that ‘jenkins.ecklc.east’ works from the browser when connected to the VPN and does not work when connecting from the public internet and verify all other functionality. 
