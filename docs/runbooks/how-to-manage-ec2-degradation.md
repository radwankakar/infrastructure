# How to Manage EC2 Degradation

## Context

From time to time, we've gotten alerts from AWS informing us that a instance is going to be retired due to hardware degradation. The email will look something like this:

```
    Hello,

    EC2 has detected degradation of the underlying hardware hosting your Amazon EC2 instance (instance-ID: i-XXXXXXXXX) associated with your AWS account (AWS Account ID: 802093990117) in the us-xxxx-1 region. Due to this degradation your instance could already be unreachable. We will stop your instance after YYYY-MM-DD HH:MM:SS UTC. Please take appropriate action before this time.

    The affected instances are listed below:

    i-XXXXXXXXX
```

You can login to the [AWS Health Dashboard](https://phd.aws.amazon.com/phd/home?region=us-east-1#/dashboard/scheduled-changes?eventID=arn:aws:health:us-west-1::event/EC2/AWS_EC2_PERSISTENT_INSTANCE_RETIREMENT_SCHEDULED/AWS_EC2_PERSISTENT_INSTANCE_RETIREMENT_SCHEDULED_dc5ec221-3dcc-4a15-b3e2-825dd5be6abe&eventTab=details) to examine the events in the Scheduled changes tab.

There are two options:

- [Migrate to Keep the Instance](#migrate-to-keep-the-instance)
- [Retire the Instance](#retire-the-instance) -- in the case the instance is no longer in use.

## Migrate to Keep the Instance

In the case that you've decided you want to keep the instance, you will have to migrate the instance to a new host.

1. Reach out to all teams that will be affected to schedule downtime for the instance. Make sure that all affected teams have agreed to the downtime window. The whole process should take just a few minutes, but best to schedule some buffer time within the downtime window.
1. Once you have team confirmation, take a snapshot of the attached EBS volume.
1. Once you have a new snapshot, [stop and start the instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Stop_Start.html). Stopping and starting will automatically migrate your instance to a new, healthy host while retaining the EBS volume attachment, private IPv4 addresses and any IPv6 addresses, associated Elastic IP addresses, and any data stored in the RAM or the instance store volumes of the host computer.
1. Once you've stopped and started the instance, check you can SSH into the instance as expected.
1. Confirm services are running by `systemctl list-units --type=service`.
1. Check with the app teams that were using the server to confirm that they have the same functionality.

## Retire the Instance

One day you will die. Your presence on this plane shall cease. And eventually all memory of you, fond or otherwise, will go with it. But do not despair, the same is true of all things. Including EC2 instances, and here you'll learn how to at least navigate through that inevitable loss.

### **BEFORE MOVING FORWARD**

You are here because the EC2 instance in question is being retired. That might be because you suspect it's no longer in use, or you're spinning up a new one to correct the mistakes of the old one, or the hardware it lives on is being shutdown. **No matter the reason, reach out to any teams/users that you suspect would possibly be using the instance before doing anything else.** This'll inform how you should, or shouldn't, move forward, as well as give any affected parties the time to grieve.

### Steps to Retiring

1. Breathe, you'll get through this.
1. Once again, get in touch with any teams/users that may be affected by the retirement. And be sure to work in coordination with them.
1. Check the metrics of the instance on AWS console for any indications of life. It's best to compare to an instance that you're sure is still in use.
1. Use the IP address of the retiring instance to search the logs of any other instances, that may interact with this one to ensure it's not in active use. i.e. grep-ing through logs on the associated server itself, looking through Cloudfront logs, etc.
1. Make a note of any resources that may be associated with the retiring instance. i.e. security groups, volumes, subnets, AMIs, snapshots, etc.
1. If there are associated resources that are not specific to the retiring instance but have components that are, make note of those components (i.e. a security group used for a bunch of instances that has a rule specific to your retiring instance).
1. Check that the instance is not a part of an autoscaling group. If it is and you delete it, it will just pop back up.
1. Check to see if there are any snapshots being taken of the attached volume. If so, [archive the last year's worth of snapshots](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/working-with-snapshot-archiving.html#archive-snapshot) (ideally automate this step). Cron should be deleting anything older than that. You'll cherish those memories later.
1. Find and take note of any relevant bits of terraform in the [environment configuration repo](https://github.com/OHS-Hosting-Infrastructure/environment-configuration), if any exist.
1. At this point run your findings by someone else with knowledge of the system.
1. Once you have the go ahead, go about retiring the EC2 instance and the previously gathered associated resources either by running the terraform with the resources in question deleted or by manually removing them. You may have to delete things in a certain order due to dependencies.
1. Breathe. You got through it, and we're proud of you.
