# Cloud.gov Feasability

Design Doc
9/29/2021
Rebecca Kilberg

## Context

We are trying to evaluate whether we can move all infrastructure into a cloud that already exists within the government context, such as cloud.gov. There are certain requirements that already exist for the apps we

## Requirements



| Resource          | Proposed solution supported? | Notes                                                                                                                                                                                                                                                                                              |
|-------------------|------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ATO               | Yes                          | FISMA low and moderate                                                                                                                                                                                                                                                                             |
| MariaDB           | Yes                          | [MySQL supported](https://cloud.gov/docs/services/relational-database/) and we have a plan to migrate to RDS from EC2.                                                                                                                                                                             |
| Account ownership | No                           | Owned by a gov rep rather than Truss                                                                                                                                                                                                                                                               |
| Server access     | No                           | You can have [users accessing the cloud.gov](https://cloud.gov/docs/orgs-spaces/roles/) organization. The IAM roles available are significantly simplified to [full admin and read only](https://cloud.gov/docs/ops/aws-onboarding/) accounts.                                                     |
| AWS organizations | No                           | It does not appear you can have multiple accounts within an AWS organization, which is the direction we're moving in.                                                                                                                                                                              |
| Drupal            | Yes                          | [7 and 8 are supported](https://cloud.gov/docs/deployment/frameworks/) but past HSICC experience with Drupal on cloud.gov has not been good. This [recently published blog post](https://cloud.gov/2021/07/02/migrating-from-legacy-drupal-to-federalist/) excludes us due to our user auth needs. |
| Java              | Yes                          | [Java is supported](https://cloud.gov/docs/deployment/frameworks/)                                                                                                                                                                                                                                 |
| Express           | No                           | [Node.js is supported but Express is not](https://cloud.gov/docs/deployment/frameworks/)                                                                                                                                                                                                           |
