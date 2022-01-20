# ECLKC Cloud.Gov Feasibility

Rebecca Kilberg
11/24/2021

## Context

We wanted to determine how difficult it would be to get various applications on cloud.gov due to [the benefits it offers around compliance, security, and best practices](../design-docs/cloud-dot-gov-feasibility). We selected the ECLKC app because we believed it would be the most difficult to migrate to cloud.gov since it uses the greatest number of services and is a Drupal app, which we were aware had some historical challenges getting onto cloud.gov. These challenges include the way Drupal depends on the local filesystem (incompatible with cloud.gov) for configuration and that the cloud.gov provided alternative was to use S3, which previous dev teams had struggled to use with Drupal. The HSICC team had attempted to port a previous Drupal app over to cloud.gov and found the S3 integration challenging. Steven Reilly, of 18F, had a similar experience with a different Drupal app migration effort. He said that part of the issue were the number of hardcoded environment variables, many of which were untracked.

## Lessons Learned

Cloud.gov is a very opinionated platform. Though it is well aligned with our approach to infrastructure, it is much harder to use with apps that do not already abide by certain expectations. For example, a containerized app or an app that runs using certain default settings (such as how the app is routed) would be much easier to deploy than one that cannot easily be containerized or deviates from a default set up. With that in mind, Cloud.gov makes it very easy to do the things it wants you to do--provisioning a DB and attaching it to an app, for example, is easy to do and can be done multiple ways (via cf CLI, a script, or manually in their GUI). Going forward, experimenting with an app that is containerized (Drupal or otherwise) is likely to yield better results.

You need to interact with the cloud.gov team any time you have an issue related to access. We're used to having full access on our teams as the administrators of the infrastructure or at least having someone on the team with full access. In this case, even the space owner (Nate from 18F) did not have that type of administrative access. However, the cloud.gov support team is extremely helpful and responsive and I would encourage you to reach out with any blockers [via email to support@cloud.gov](support@cloud.gov).

Somewhat surprisingly, we did not run into any show stoppers--indicators that would absolutely derail this process. Instead, we ended our exploration due to having competing priorities and an expectation that we could make faster progress on cloud.gov from other angles (such as starting with a different app). Given our team's background, one of the biggest challenges was the lack of familiarity with Drupal, PHP, and buildpacks.

The ultimate takeaway was that there are many different small tweaks that would be necessary to getting ECLKC on cloud.gov (the ones encountered are detailed below). I suspect having a pair work on something similar full time for 2 weeks would yield greater progress.

## Accessing cloud.gov

To begin, we had to get access to cloud.gov. We relied on our partner at 18F, Nate Price, to get us access. As someone with a .gov email address, he was able to sign up for a [free sandbox space](https://cloud.gov/docs/pricing/free-limited-sandbox/). He then granted the rest of us access. At this point, we realized no one had permission to create an organization for us to use, and that the free sandbox space was too small for us to set up anything meaningful.

18F partner Ryan Ahearn negotiated with TTA SmartHub, who already had a cloud.gov account, to allow us to use their organization to set up our own space. We ended up being given access to the SmartHub organization (`hhs-acf-ohs-tta`) with a 2GB memory allocation for our exploration. The space we were given is called `eclkc-investigation`.

Once we had permission to access cloud.gov, I installed [cloudfoundry CLI (7)](https://docs.cloudfoundry.org/cf-cli/install-go-cli.html#pkg-mac) locally and was able to [access the web GUI and use cf on the command line](https://cloud.gov/docs/getting-started/setup/).

## Standing up the server

You can use cloud.gov in one of two ways: containerize your app outside of cloud.gov and run it inside cloud.gov or push your app code in cloud.gov and have the container built for you. Either way, the apps well-suited to cloud.gov must run in stateless container.

Initially, I believed we could lean on the containerization work done by the HSICC team and port that over to cloud.gov. We also thought we could lean on the example shared with us by 18F and the cloud.gov team of a [Drupal 8 example repo for cloud.gov](https://github.com/cloud-gov/cf-ex-drupal8). The example was of an app built on cloud.gov rather than one migrated to cloud.gov, but even so it seems like a reasonable start.

I cloned the [HSICC repo](https://github.com/HSICC/drupal-composer-project). At this point,  I ran `cf target -o hhs-acf-ohs-tta -s eclkc-investigation` to target the correct org and space. I then ran `cf push hsicc` from within the repo to attempt to run it on cloud.gov just in case things *just worked*. It required a `manifest.yml`, which I cribbed from the [Drupal example repo](https://github.com/cloud-gov/cf-ex-drupal8/blob/master/manifest.yml) (removing the apt buildpack).

After that failed, I began following the [instructions in the DDEV guide](https://github.com/HSICC/drupal-composer-project/blob/develop/README.ddevVM.md). After running into some blockers trying to get started, I paired with Sam from the HSICC team, who said that in fact they do not use that tool and that the Readme is out of date. They do not use Docker. Instead, Sam runs a local instance of the app on a server. We were able to make some progress: we hit a disk quota issue, which we addressed by increasing the disk quota in the `manifest.yml` file to 600MB, although Sam was unsure why so much disk space was being used. Sam said if we continued to use this approach, we'd have to do the following:

* Install the patches package on the OS (we had commented it out at this point, but resolved later on)
* Create a production RDS DB instance and pass the settings in `web/sites/defaults/settings.php`. We could use the following command to create a db with the fields of interest set:

    ```[bash]
    CREATE DATABASE db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

    GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES ON db.* TO 'db'@'%' IDENTIFIED BY 'db';
    ```

* Take the data (`production_full.sql`) from SFTP server that is synced every night.
* Specify path of static files in the `web/sites/defaults/settings.php` in the public path.

    ```[bash]
    $settings['file_private_path'] = '/var/www/web/private';
    $settings['file_temp_path'] = '/tmp';
    $settings['file_public_path'] = '../../drupal_files';
    $settings['config_sync_directory'] = './../config/sync';
    ```

  **Private path**: Drupal stores non-publicly available info. Permissions layer on top. We don't have many--could run without that.

  **Tmp files** -- make sure the server has write access to that folder.

  **Public path**--everything on the drupal files in SFTP folders has to be mapped here.

  **Config sync**--can leave as is.

* Enable one of the host names to connect (avoids XRSF)
* Generate a salt hash and put it in settings.php

    ```[bash]
    $settings['hash_salt'] = 'WHATEVER';
    ```

  Note: If you want to synchronize a local version to the prod version, you have to use the same salt
* Normally when you deploy and make config changes, you have to run a command to import config into db. Since we're working with most up to date config and db version, we don't have to run that at this time.

I did not end up pursuing these instructions because I decided instead to attempt the second approach of pushing the app code and having cloud.gov build the container. Partially this was due to not being able to easily spin up a container locally and partially this was due to the way that example Drupal repo showed of having cloud.gov deploy an RDS instance and attach it to the instances with secrets injected.

## Second attempt

I saw that the example Drupal app had a `deploy-cloudgov.sh` script, which contained cf cli commands to check for and create database, secrets, and storage services and appropriately associate them with the app so it's not flying blind.

Adam on the Truss team directed me how to solve the issue with the composer.json missing patches file error by correcting the path pointing to the patches.

He also directed me to the example Drupal app's [`bootstrap.sh`](https://github.com/cloud-gov/cf-ex-drupal8/blob/ed81548d9c091cc5d98597a62c6fc6e981ac1654/bootstrap.sh), which injected the various credentials and secrets into the database and secret store for our app to be able to function. In order to reference the bootstrap script, I had to also add the [`options.js`](https://github.com/cloud-gov/cf-ex-drupal8/blob/master/.bp-config/options.json) file, which set the root directory and added the bootstrap script as a preprocess command.

Adam instructed me to add various settings files as well, including the [`settings.cf.php`](https://github.com/cloud-gov/cf-ex-drupal8/blob/ed81548d9c091cc5d98597a62c6fc6e981ac1654/web/sites/default/settings.cf.php) file in order to have an additional layer of specificity for cloudfoundry settings.

All changes made to the HSICC team's Drupal app in this effort can be found in a [branch called `rek-cloudgov` on their repo](https://github.com/HSICC/drupal-composer-project/compare/rek-cloudgov).

## Database Loading

We believed that part of the issue why we weren't seeing anything on the launched site was that there was nothing in the database. Therefore, we decided to do a database dump from the HSICC prod DB into the RDS instance running in cloud.gov.

To do so, I ran a mysql dump on the MariaDB instance of the HSICC db. In order to avoid copying the db dump onto my computer, I copied it to the Ansible/Nagios EC2 instance using scp (`scp -i myidentityfile -3 centos@10.0.1.77:/home/centos/hsiccdump.sql centos@10.2.0.6:/home/centos/hsiccdump.sql`). I then installed [cloudfoundry CLI (7)](https://docs.cloudfoundry.org/cf-cli/install-go-cli.html#pkg-mac) in the Ansible/Nagios machine. Then, using the instructions from cloud.gov docs to [export a database](https://cloud.gov/docs/services/relational-database/#access-the-data-in-the-database), I used the [`cf connect-to-service` plugin](https://github.com/cloud-gov/cf-service-connect#readme) to open an SSH tunnel from the Ansible/Nagios instance and run a mysql query using the port, host, username, password, and name (database name) it generated. This meant running a command similar to `mysql -h 127.0.0.1 -P 40742 -u urzzofrodm29u325 -p -f -D cgawsbrokerprodcz6fgyioasosi39 < hsiccdump.sql` in another window on the Ansible/Nagios instance. At the same time, I could connect to the db in a third window to watch the transfer's progress by running something similar to `mysql -h 127.0.0.1 -P 40742 -u urzzofrodm29u325 -p -D cgawsbrokerprodcz6fgyioasosi39` and then running MySQL commands.

I ran into a number of errors during the database loading. The first was that the database died after getting about halfway through the dump and wouldn't let me connect. This was because the instance was too small. I fixed this by unbinding the database, deleting the database, then rerunning the `deploy-cloudgov` script with a larger database instance (`medium-mysql` instead of `small-mysql`). The cloud.gov had to step in and help with this, because I kept encountering the following error:

```[bash]
FAILED Server error, status code: 400, error code: 60007, message: The service instance cannot be created because paid service plans are not allowed
```

This error was resolved by the cloud.gov team enabling paid services, which had been disabled because we had a space quota since we were using TTA's space.

The next error I consistently encountered was:

```[bash]
 ERROR 2013 (HY000) at line 27424: Lost connection to MySQL server during query
```

This we resolved by adding `max_allowed_packet=64M` to `my.cnf` on the Ansible/Nagios instance.

Then we started getting:

```[bash]
 ERROR 2013 (HY000) at line 27424: Lost connection to MySQL server during query
```

This was fixed by adding these four timeout-related variables to `my.cnf`:

```[bash]
innodb_buffer_pool_size = 64M
interactive_timeout=120;
connect_timeout=120;
wait_timeout=120;
```

Although I am not sure which of these actually fixed the issue because I did not add them one by one.

Then we got this error:

```[bash]
`ERROR 1062 (23000) at line 31469: Duplicate entry '/former/hslc/ecdh/eecd/Curriculum/Deﬁnition and Requirements/C' for key 'redirect_404.PRIMARY'`
```

Which we fixed by adding the `-f` flag to force the mysql command to run to completion, which indeed it did! Yielding the following errors in its wake:

```[bash]
ERROR 1062 (23000) at line 31469: Duplicate entry '/former/hslc/ecdh/eecd/Curriculum/Deﬁnition and Requirements/C' for key 'redirect_404.PRIMARY'
ERROR 1062 (23000) at line 31661: Duplicate entry 'años-3319-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31665: Duplicate entry 'áreas-2142-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31667: Duplicate entry 'beneﬁts-5611-en-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31671: Duplicate entry 'capacitación-2047-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31676: Duplicate entry 'comité-1779-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31682: Duplicate entry 'cómo-1592-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31684: Duplicate entry 'deberá-3319-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31687: Duplicate entry 'diagnóstico-2769-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31689: Duplicate entry 'diﬀerent-8459-en-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31692: Duplicate entry 'educación-1395-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31697: Duplicate entry 'están-3319-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31707: Duplicate entry 'gestión-2116-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31709: Duplicate entry 'guías-1916-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31718: Duplicate entry 'información-1912-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31729: Duplicate entry 'más-1593-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31736: Duplicate entry 'niño-1592-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31739: Duplicate entry 'opción-3319-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31741: Duplicate entry 'oﬃce-8391-en-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31742: Duplicate entry 'participación-1561-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31744: Duplicate entry 'periódica-2769-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31747: Duplicate entry 'prácticos-2825-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31748: Duplicate entry 'preparación-1463-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31754: Duplicate entry 'rápidamente-2142-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31760: Duplicate entry 'reﬂect-8384-en-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31762: Duplicate entry 'sección-3319-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31763: Duplicate entry 'según-2142-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31771: Duplicate entry 'staﬀ-8378-en-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31772: Duplicate entry 'stuck͟-4357-en-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31773: Duplicate entry 'supervisión-2142-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31774: Duplicate entry 'tamaño-3319-es-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31792: Duplicate entry 'ﬁne-8462-en-node_search' for key 'search_index.PRIMARY'
ERROR 1062 (23000) at line 31816: Duplicate entry '3ªedicion' for key 'search_total.PRIMARY'
ERROR 1062 (23000) at line 31817: Duplicate entry 'karakuş' for key 'search_total.PRIMARY'
```

In addition, I intermittently got

```[bash]
  ERROR 1053 (08S01) at line 27617: Server shutdown in progress
```

which I dealt with simply by rerunning the command.

## Death Knell

The issue we're currently facing is that there is something off with the routing within the app regarding PHP and Drupal. It is likely related to a default expected route that the app diverges from. We've made it to the point of encountering the following error when visiting our cloud.gov site (hsicc.app.cloud.gov):

```[bash]
The website encountered an unexpected error. Please try again later.

Drupal\Component\Plugin\Exception\PluginException: Plugin (node_book_assigned) instance class "Drupal\book_block_visiblity\Plugin\Condition\NodeBookAssignedCondition" does not exist. in Drupal\Component\Plugin\Factory\DefaultFactory::getPluginClass() (line 97 of core/lib/Drupal/Component/Plugin/Factory/DefaultFactory.php).
```

We don't think it's actually about the plugin, but suspect it's about the directory structure and routing. However, we've reached the end of a very long-awaited timebox and so are calling it on this effort for now.

## Helpful Hints

To access long-term logs for your app, go to: [https://logs.fr.cloud.gov/app/home](https://logs.fr.cloud.gov/app/home).

To ssh into your app from the command line, `cf ssh appname`.

## Reference Pairing Sessions

[Speaking to cloud.gov team about getting ECLKC on (10/14)](https://drive.google.com/file/d/1lsIGWfeCMU3lmDXfUym6N88IKgJKZYkG/view)
[Pairing with Sam (HSICC--10/26)](https://drive.google.com/drive/folders/1i5bxPwTaINSaaUFv8qpppaHW-YUvZjq3?usp=sharing)
[Paring with Adam (1--10/26)](https://drive.google.com/drive/folders/1_uvFSacgI6ROo11MvFYEe_9j2C2kZTU4?usp=sharing)
[Pairing with Adam (2--11/3)](https://drive.google.com/drive/folders/1LPciuvHtT5Jmao40M8XvB5UR03r2Ic65?usp=sharing)
[Pairing with Adam (3--11/3)](https://drive.google.com/drive/folders/1MNyZj2zLh-4wUUcPZUeF3tIeWa2c8_Qw?usp=sharing)
[Reid and Eady team pair--11/24](https://drive.google.com/drive/folders/1ry8Xfls_smG3MRTbL2fnbO0QNAEy2K2p?usp=sharing)