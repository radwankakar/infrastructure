# Saying Goodbye To an EC2 Instance

One day you will die. Your presence on this plane shall cease. And eventually all memory of you, fond or otherwise, will go with it. But do not despair, the same is true of all things. Including EC2 instances, and here you'll learn how to at least navigate through that inevitable loss.

## **BEFORE MOVING FORWARD**

You are here because the EC2 instance in question is being retired. That might be because you suspect it's no longer in use, or you're spinning up a new one to correct the mistakes of the old one, or the hardware it lives on is being shutdown. **No matter the reason, reach out to any teams that you suspect would possibly be using the instance before doing anything else.** This'll inform how you should, or shouldn't, move forward, as well as give any affected parties the time to grieve.

## Steps to Retiring

- Breathe, you'll get through this.
- Check the metrics of the instance on AWS console for any indications of life. It's best to compare to an instance that you're sure is still in use.
- Use the IP address of the retiring instance to search the logs of any other instances that may interact with this one to ensure it's not in active use.
- Track down and make a note of any resources that may be associated with and are **specific** to the retiring instance. i.e. security groups, volumes, etc.
- Check to see if there are any snapshots being taken of the attached volume. If so be sure to archive the most recent snapshot. You'll cherish those memories later.
- Find and take note of any relevant bits of terraform. If any exist.
- At this point run your findings by someone else with knowledge of the system.
- Once you have the go ahead, go about retiring the EC2 instance and the previously gathered associated resources either by running the terraform with the resources in question deleted or by manually removing them. You may have to delete things in a certain order due to dependencies.
- Breathe. You got through it, and we're proud of you.
