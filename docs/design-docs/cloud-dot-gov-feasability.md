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
| MariaDB           | Maybe                          | [MySQL supported](https://cloud.gov/docs/services/relational-database/) and we have a plan to migrate to RDS from EC2. MariaDB is not explicitly supported, so there may be some config deviation.                                                                                                                                                                            |
| Account ownership | No                           | Owned by a gov rep rather than Truss                                                                                                                                                                                                                                                               |
| Server access     | No                           | You can have [users accessing the cloud.gov](https://cloud.gov/docs/orgs-spaces/roles/) organization. The IAM roles available are significantly simplified to [full admin and read only](https://cloud.gov/docs/ops/aws-onboarding/) accounts.                                                     |
| AWS organizations | No                           | It does not appear you can have multiple accounts within an AWS organization, which is the direction we're moving in. However, you can have multiple organizations with multiple spaces within each organization, which could mean there was a single organization per app, and then 3 environments per organization.                                                                                                                                                                             |
| Drupal            | Yes                          | [7 and 8 are supported](https://cloud.gov/docs/deployment/frameworks/) but past HSICC experience with Drupal on cloud.gov has not been good. This [recently published blog post](https://cloud.gov/2021/07/02/migrating-from-legacy-drupal-to-federalist/) excludes us due to our user auth needs. |
| Java              | Yes                          | [Java is supported](https://cloud.gov/docs/deployment/frameworks/)                                                                                                                                                                                                                                 |
| Express           | Yes                           | [Node.js is supported, which means Express should be on top of that](https://cloud.gov/docs/deployment/frameworks/)                                                                                                                                                                                                           |

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



