# Deploying ECLKC

## Context

One day, all of our deployments will be automated. Until then, they are nasty as heck.
Here's what's happening during the Drupal ECLKC deploy.

## Development

1. Code that is "In Progress" are not yet checked into the develop branch in GitHub.
   Code that is "In Review" will have been checked into the develop branch.
   The develop branch is the HSICC team equivalent to master or main branch.
1. Once code is merged to the Develop branch, the [Github drupal composer project](https://jenkins.eclkc.info/view/Drupal/job/GitHub-drupal-composer-project/) job is run automatically in Jenkins. Sam says this deploys to the dev env from the Develop branch.

## Staging

1. Sam syncs the environments and files via Jenkins jobs in order to have the staging env as close to the production env as possible before deploying. First he runs [Drupal Stage File Sync](https://jenkins.eclkc.info/job/Drupal%20Stage%20File%20Sync/), which identifies the files that are different between the nightly SFTP server sync from stage and what is currently in stage. This creates a backup of the production DB and stores it on the SFTP server.

1. Sam then runs [Drupal Production to Stage DB Sync](https://jenkins.eclkc.info/job/Drupal%20Production%20to%20Stage%20DB%20Sync/), which downloads that file from the SFTP server and restores the database from production on staging.

1. Sam then runs `drush cr` on the stage1 machine to clear the Drupal cache.

1. Once that is complete, Sam runs the deployment job ([GitHub Stage Branch Switch](https://jenkins.eclkc.info/job/Github%20Stage%20Branch%20Switch/configure)), which runs on both Stage1 and Stage2. This job:

   - Pulls the code from the repo to both staging servers
   - Runs composer install (to install any new modules/dependencies)
   - Refreshes cache
   - Imports new config from repo to update db
   - If the modules contain updates or scripts that may affect the db, those scripts are run to update db
   - Flushes Drupal cache again
   - Restarts Varnish

   Sam specifies which branch it runs on (usually specifies the develop branch). This is a feature they want to keep.

1. Sam takes a look at the Jenkins console for the job to verify that there are no warnings.

1. Everything is now deployed into Stage with a production copy of the database.

1. Sam does a sweep of the staging site [stage.eclkc.info](https://stage.eclkc.info). He makes sure there are no major, obvious issue. When he's done, he alerts Bhuvan and one of them set the status of the issue to "Testing".

1. Bhuvan tests each of the issues in the the Fix Version queue in the "Testing" state. He will also complete regression testing.

1. The team will do User Acceptance Testing for the issues that require it. This is relatively infrequent, and are typically UI-related. Usually this UAT looks like a demo or training rather than formal UAT. If there is a large functional change, they may have stakeholders validate against a list of requirements.

1. If there are additional updates, they can run them at any time in staging.

Depending on whether they want to install or remove a module, they have to complete various certain steps in a certain order. If they are removing, they first disable the module, uninstall and then remove the code. If they are installing, they pull the code and then install the module with its config.

## Production

Everything in production is manual. Sam does all the work himself, but hopes to automate it.

Previously, in Drupal 7, you would make all parameter, module, and configuration changes for each environment via the Drupal UI. Now, Drupal has **configuration management**, which handles the parameters, layout, and other configs across environments. They use this UI. The configuration can be exported, stored in the repository and imported in a different environment.

To uninstall a module, Sam disables it in the UI or through the command line (via drush command or config import) and then runs composer and the code for the module is removed.

1. [Using this guide to support the ECLKC Drupal deploy](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/runbooks/how-to-support-eclkc-drupal-deploy.md), the Truss infrasec team [syncs the latest data to Lifeboat](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/runbooks/how-to-support-eclkc-drupal-deploy.md#sync-the-latest-application-data-to-lifeboat).
1. The Truss infrasec team then [routes traffic to Lifeboat only for the Drupal app](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/runbooks/how-to-support-eclkc-drupal-deploy.md#route-traffic-to-lifeboat-only-for-drupal).
1. Sam does not have to synchronize the files between production and staging database when deploying to production since the production database is up to date. He does not have to import the database either for the same reason.
1. Otherwise, he runs all of the commands in the various jobs automated in staging.
1. Sometimes, they have to do something extra due to a module requirement or a security header update. Unlike in staging, they intend to have all changes happen during the same period in the prod environmnent.
1. Eady regularly updates the content security policy (CSP) headers on the Varnish configuration. Sam does not have write access to that.
1. Sam says you cannot just blindly run the Jenkins jobs to deploy into production like you do in staging. This is because there are certain configs and variables that are environment specific that they are not always aware of. **Sam** may be aware of these specifics, but it is not common knowledge, nor does the system accommodate.
1. After the Drupal deployment is complete, the Truss infrasec team [reroutes Varnish traffic back to production](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/runbooks/how-to-support-eclkc-drupal-deploy.md#reroute-varnish-traffic-back-to-production).

## Other information

They have a PHP configuration file (`settings.php`) in the filesystem where they store environment-specific parameters (such as API keys). Their current `settings.php` file also refers to a `settings.ddev.php` file, which is further customized for the project (stores vars such as database, username, and password). [DDEV](https://ddev.readthedocs.io/en/stable/) is not being used in general by the HSICC team as a tool, but they are using the `settings.ddev.php` file. They don't use DDEV because it does not work to set up local environments.

Sensitive configuration is stored in the settings files. Currently, variables are hard-coded according to environment. They are not contained in the repo, they are only on the servers.

## Non-Drupal Releases

To deploy non-Drupal releases, they pull the code and try to deploy. They deploy that way for Express apps, for the Java servlets, and changes to cronjobs.

### Java Servlets

They would like to get rid of the Java servlets because they are very hard to maintain. There are no Java servlets on the repo and there are issues with updating them and maintaining their security. The team doesn't have the dependencies for the WAR file (a file used to distribute servlets). They sometimes have the source code or sometimes have the just the binaries.

### Center Locator (Express App)

Devs work on their local instances, which has to have the Drupal apps, 3 or 4 express apps, configuration variables, and 3rd party applications. In some cases, you are connecting to a production instance of a tool rather than an isolated instance for another environment (this is true in the case of Lingotek). This means in these cases they always have to be very careful.

In the case of Center Locator, which is an express app, they have to check the code in the dev environment rather than the local environment.

The Center Locator code is connected to their backend GitHub repo, [HSES-API](https://github.com/HSICC/hses-api).

1. Push the changes to the repo.
1. On the staging server, Sam will run `git pull` to get the new code.
1. Sam will remove node modules manually.
1. Sam will run `npm install` to install the new dependencies.
1. Sam may restart the server, which he can do on staging servers but not on production.

They will need to figure out what to do depending on the changes they're expecting to make. They will do it manually in all environments. They have had to restore from a previous copy of files in the past because they had deleted a necessary vendor binary and then were unable to run `npm install`.
