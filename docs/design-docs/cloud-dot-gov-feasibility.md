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
1. Lack of full coverage: Because of the limitations of cloud.gov, we would still have to support certain services on AWS independently. That means that we will likely never be able to fully depend on cloud.gov to host our services such as email integration. Therefore, we would expect to continue to broker certain services ourselves.
1. File system woes: Cloud.gov has claimed that it can run Drupal apps, but has specified that any app that keeps information in the filesystem is likely to encounter hardship, which is backed up by anecdotal information shared by other teams in our ecosystem. This is consistent with favoring twelve factor apps, because keeping variables within a filesystem is by definition not stateless. However, given our main app is a Drupal app, we wonder whether we will end up brokering so many services on our own that it doesn't really buy us that much to have the other apps on cloud.gov. We hope to alleviate this concern by having the app team work to move away from this type of filesystem reliance as we onboard other teams to cloud.gov.

## Hybrid Approach

At this point in our research, it seems like the most promising path is to attempt a hybrid approach. For that, we would create a decision tree to guide apps to determine whether they can be on cloud.gov to begin. We would likely provide a few common shared services (such as CAS and Mail Inquiry) that we would broker ourselves on AWS that apps could use while still being on cloud.gov.

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
| Drupal            | Somewhat                          | [7 and 8 are supported](https://cloud.gov/docs/deployment/frameworks/) but there are issues with how Drupal relies on certain configs that live in the filesystem for some apps. |
| Java              | Yes                          | [Java is supported](https://cloud.gov/docs/deployment/frameworks/)                                                                                                                                                                                                                                 |
| PHP              | Yes                          | [PHP is supported](https://cloud.gov/docs/deployment/frameworks/)                                                                                                                                                                                                                                 |
| Express           | Yes                           | [Node.js is supported, which means Express should be supported on top of that](https://cloud.gov/docs/deployment/frameworks/)                                                                                                                                                                                                           |
| Mail Inquiry (email)         | No                           | Sending email from a .gov account is not supported.                                                                                                                                                                                                           |


