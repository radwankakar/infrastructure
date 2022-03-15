# Saying Goodbye To an EC2 Instance

One day you will die. Your presence on this plane shall cease. And eventually all memory of you, fond or otherwise, will go with it. But do not despair, the same is true of all things. Including EC2 instances, and here you'll learn how to at least navigate through that inevitable loss.

## **BEFORE MOVING FORWARD**

You are here because the EC2 instance in question is being retired. That might be because you suspect it's no longer in use, or you're spinning up a new one to correct the mistakes of the old one, or the hardware it lives on is being shutdown. **No matter the reason, reach out to any teams/users that you suspect would possibly be using the instance before doing anything else.** This'll inform how you should, or shouldn't, move forward, as well as give any affected parties the time to grieve.

## Steps to Retiring

1. Breathe, you'll get through this.
1. Once again, get in touch with any teams/users that may be affected by the retirement. And be sure to work in coordination with them.
1. Check the metrics of the instance on AWS console for any indications of life. It's best to compare to an instance that you're sure is still in use.
1. Use the IP address of the retiring instance to search the logs of any other instances, that may interact with this one to ensure it's not in active use. i.e. grep-ing through logs on the associated server itself, looking through Cloudfront logs, etc.
1. Make a note of any resources that may be associated with the retiring instance. i.e. security groups, volumes, subnets, AMIs, snapshots, etc.
1. If there are associated resources that are not specific to the retiring instance but have components that are, make note of those components (i.e. a security group used for a bunch of instances that has a rule specific to your retiring instance).
1. Check that the instance is not a part of an autoscaling group. If it is and you delete it, it will just pop back up.
1. Check to see if there are any snapshots being taken of the attached volume. If so be sure to archive the most recent snapshot. You'll cherish those memories later.
1. Find and take note of any relevant bits of terraform in the [environment configuration repo](https://github.com/OHS-Hosting-Infrastructure/environment-configuration), if any exist.
1. At this point run your findings by someone else with knowledge of the system.
1. Once you have the go ahead, go about retiring the EC2 instance and the previously gathered associated resources either by running the terraform with the resources in question deleted or by manually removing them. You may have to delete things in a certain order due to dependencies.
1. Breathe. You got through it, and we're proud of you.
