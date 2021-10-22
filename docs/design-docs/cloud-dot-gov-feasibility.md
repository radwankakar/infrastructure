# Cloud.gov Feasibility

Design Doc
9/29/2021
Rebecca Kilberg

## Context

We are trying to evaluate whether we can move all infrastructure into a cloud that already exists within the government context, such as cloud.gov. There are certain requirements that already exist for the apps we will be supporting, so part of our research effort is to make sure those are compatible.

[Cloud.gov](https://cloud.gov/) is a Platform as a Service (PaaS) created by 18F for applications to run in a government-compliant environment. It is FedRAMP authorized, so essentially takes on the risk of what is typically the app and hosting team's responsibility for maintaining an ATO.

As a PaaS, Cloud.gov does not expose AWS itself, instead exposing a [limited number of services](https://cloud.gov/docs/services/intro/) to the platform. Cloud.gov is a stateless ecosystem that uses immutable infrastructure (meaning it will deploy a new instance of your system whenever changes are made). That means it works best for apps that are already containerized and are not stateful.

## Benefits

There are a few significant benefits of using cloud.gov.

1. Compliance: A major concern on this project is maintaining an ATO ([Authority to Operate](https://www.acf.hhs.gov/digital-toolbox/content/acronyms)) not just for the hosting platform but for all the apps hosted on the platform. Previously, the hosting team had only been responsible for an ATO for ECLKC, but since the team's purview has grown, part of the new mandate includes making sure that app teams can successfully acquire and maintain their own ATOs. Cloud.gov [covers up to 60%](https://cloud.gov/docs/overview/cloudgov-benefits/#2-compliance-with-federal-requirements) of the FISMA Moderate ATO controls required, which would significantly lessen the burden of ATO maintenance.
1. Security: [Cloud.gov manages security concerns for hosted applications](https://cloud.gov/docs/overview/cloudgov-benefits/#1-security), essentially moving the risk from the hosting team up onto the platform. In addition, we believe cloud.gov has a similar approach to what we would suggest to app teams regarding secure practices. Given cloud.gov manages services on AWS, it covers typical attack vectors such as IAM permissions and account-wide permissions.
1. Practice improvement: Cloud.gov's approach to infrastructure, like ours, favors software built with the [Twelve Factor App](https://12factor.net/) methodology as  a guiding force. We are encouraging our application teams to evaluate their current app implementations with an eye to how closely they hew to these recommendations. Getting apps onto cloud.gov would align with efforts to standardize certain practices that we want to encourage such as making it easy to bring up a service in multiple environments and closing the gaps between dev and prod environments.

## Concerns

1. Preparedness/Ease: Although we are asking application teams to invest in education and improving practices around areas such as immutable infrastructure and CI/CD, none of the app teams are currently at a phase where moving them onto cloud.gov would not require some amount of implementation change. Part of our approach has been to get to try to slowly standardize on support in AWS while still supporting some divergence. Using cloud.gov would require a more prescriptive approach than we have taken to this point, although it aligns with our ultimate expected destination.
1. Lack of full coverage: Because of the limitations of cloud.gov, we would still have to support certain services on AWS independently. That means that we will likely never be able to fully depend on cloud.gov to host our services such as email integration.
1. Unmanaged

## Costs

[The cost of hosting on cloud.gov](https://cloud.gov/pricing/) would vary depending on application size and whether we were pursuing FISMA Low or FISMA Moderate. If FISMA Low, ~$25k/year plus ~$1,500/year per GB memory. If FISMA Moderate, ~$110k/year plus ~$1,500/year per GB memory. Our current budget for this project is $60k/year. This means that if we stuck with FISMA low, even with a hybrid option this is still likely within the current budget. If we need to go with FISMA moderate, however, it is not.

## Requirements

These are not an exhaustive list of requirements.


| Resource          | Proposed solution supported? | Notes                                                                                                                                                                                                                                                                                              |
|-------------------|------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ATO               | Yes                          | FISMA low and moderate                                                                                                                                                                                                                                                                             |
| MariaDB           | Somewhat                          | [MySQL supported](https://cloud.gov/docs/services/relational-database/) and we have a plan to migrate to RDS from EC2. MariaDB is not explicitly supported, so there may be some config deviation.                                                                                                                                                                            |
| Account ownership | No                           | Owned by a gov rep rather than Truss                                                                                                                                                                                                                                                               |
| Server access     | No                           | You can have [users accessing the cloud.gov](https://cloud.gov/docs/orgs-spaces/roles/) organization. The IAM roles available are significantly simplified to [full admin and read only](https://cloud.gov/docs/ops/aws-onboarding/) accounts.                                                     |
| AWS organizations | No                           | It does not appear you can have multiple accounts within an AWS organization, which is the direction we're moving in. However, you can have multiple organizations with multiple spaces within each organization, which could mean there was a single organization per app, and then 3 environments per organization.                                                                                                                                                                             |
| Drupal            | Somewhat                          | [7 and 8 are supported](https://cloud.gov/docs/deployment/frameworks/) but there are issues with how Drupal relies on certain configs that live in the filesystem. |
| Java              | Yes                          | [Java is supported](https://cloud.gov/docs/deployment/frameworks/)                                                                                                                                                                                                                                 |
| Express           | Yes                           | [Node.js is supported, which means Express should be on top of that](https://cloud.gov/docs/deployment/frameworks/)                                                                                                                                                                                                           |
| Mail Inquiry (email)         | No                           | Sending email from a .gov account is not supported.                                                                                                                                                                                                           |

Notes:

Does not expose AWS in any shape or form
We don't spin up AWS services
You get things like RDS exposed to the platform
It's its own ecosystem in terms of user management and all those things.

If something can live in a stateless container, it's well suited for cloud.gov.

The Drupal team if they were doing anything that stored things on the filesystem, any time that the app crashed or redeployed, the filesystem is gone.
They should be storing in S3.

The reason it's stateless is for scaling reason. If you have state storage on a file system.

You could use EFS and NFS to share that state, but it's so slow that your performance will take enough of a hit so it's not worth it.
Force the stateless mindset.

You push your app code and the container is built for you.
Uses buildpacks -- language layer things that build the full container and run it for you. They were exposing that you could pre-build a docker container but that means there's an ATO caveat. Certain controls are inherited if you let cloud.gov build it for you, vs building yourself.

Way logs work -- have a command line client that you can push things up and allows you to read realtime logs. There's a log subsystem. All of that pushed over the web is all read only. ELK.

Have top level org, dev, prod space. You can turn on and off individual audit access.
Recommended way to do it--developers get access to dev space, can do what they want.
Production space request robot user, plug that into CI system.
Multiple apps in the same space.

Probably you'd want multiple orgs. Keep track of each org as a cost center.

Access for server side.
It can also be tied into SSO (if it supports SAML).
Use a cloud.gov account instead of a SSO solution.

DB read access?
Not creating RDS users but you could create MySQL auth to make read only users. Would have an issue with direct access to the applications. If you want to give direct access to db, users also need access to your space. Typically you'd bind a temporary app to that db.
When you instantiate a service, like the RDS service, you pick out a plan. Create the instance. Once it's created, it just sits in the space. Then you'll bind the instance to an app to get creds, which get shoved into the env for that app. Access the data, creates a temp app--creates an SSH tunnel to the container to get access. If you do use the bind of the app, it will use the admin creds by default--
So then would have to create your own ssh tunnel solution . You'd use the admin creds to create your own users and then make your own tunnel.
Or put a auth GUI on top of it and make them access thru webapp.


Node.JS would support Express.

MariaDB may not be usable, but may be mostly compatible.




