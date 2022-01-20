# Coaching Companion Cloud.Gov Feasibility

Rebecca Kilberg
1/29/2022

## Context

We wanted to determine how difficult it would be to get various applications on cloud.gov due to [the benefits it offers around compliance, security, and best practices](../design-docs/cloud-dot-gov-feasibility). After investigation how difficult it would be to get the [ECLKC app on cloud.gov](../eclkc-cloudgov.md), we moved on to trying with Coaching Companion (CC). We believed CC would be the simplest to migrate to cloud.gov since it uses few services and only uses PHP on the backend. We were correct that it was much easier to get onto the platform than the ECLKC app. The biggest issues we encountered were with nginx configuration regarding routing. Although not fully fleshed out, we believe it would be a relatively low lift to transfer CC to cloud.gov.

Throughout this effort, we had help from Roger Ruiz on the app eng team, who had previously worked on the cloud.gov development team at 18f.

## Standing up the server

Much like with ECLKC, I started by cloning the [HSCC repo](https://github.com/HSICC/OHSCC). At this point,  I logged in by running `cf login -a api.fr.cloud.gov --sso` and then ran `cf target -o hhs-acf-ohs-tta -s eclkc-investigation` to target the correct org and space. I then ran `cf push cc` from within the repo to attempt to run it on cloud.gov just in case things *just worked*. It required a `manifest.yml`, which I cribbed from the [Drupal example repo](https://github.com/cloud-gov/cf-ex-drupal8/blob/master/manifest.yml). I wanted to keep things as simple as possible, so I removed whatever I wasn't sure we needed.

```yml
---
default_config: &defaults
  buildpacks:
    - php_buildpack
  disk_quota: 512M
  timeout: 180
  services:
    - database
applications:
- name: cc
  <<: *defaults
  memory: 256M
  instances: 1
```

I then once again grabbed the  `deploy-cloudgov.sh` script from the example app mentioned above, which contained cf cli commands to check for and create database, secrets, and storage services and appropriately associate them with the app so it's not flying blind.

In the end, the only directives from this script that I ended using were `cf create-service aws-rds small-mysql database` and `cf push cc`. Ultimately, we would be managing environment variables in a secrets store and so would have to set up a secrets service as well.

We immediately noticed an nginx error and I recalled that you could specify the webserver in an [options.json](https://docs.cloudfoundry.org/buildpacks/php/gsg-php-config.html#options) file, so we added a `WEB_SERVER` field with `nginx` value.

## Nginx Config

At this point, most of the pages were returning 500s or loading blank pages with 200s. Reid realized that the /help page was loading, and Avanti noted that help had an index.html, while all other routes relied on index.php. We tried to look at nginx logs but found that there weren't any. Initially we thought that meant nginx wasn't running, but then we started exploring the nginx configs on the server instance (using `cf ssh cc` to access it). Eady gave us the prod nginx config to compare, and we found that the `server-locations.conf` file was specifying configs that would significantly alter function. We found that you could specify nginx configs easily within a buildpack config directory ([.bp-config](https://docs.cloudfoundry.org/buildpacks/php/gsg-php-config.html#engine-configurations)). We used that to create an `nginx.conf` and `server-locations.conf` to override the [php buildpack defaults](https://github.com/cloudfoundry/php-buildpack/tree/master/defaults/config/nginx). Each time one of these changes were made, we had to repush the app to see them take effect.

In the `nginx.conf` we just made one change and added an index line (`index        index.php index.html;`) in the `http` block.

In the `server-locations.conf`, however, we made changes to the `location ~ \.php$` block, altering `fastcgi_pass` value and adding `try_files $uri =404;`. This is what we ended up with:

```bash
location = /50x.html {
        root /usr/share/nginx/html;
}

location / {
        try_files $uri /index.php?$query_string;
}

location /DbAdmin {
        allow 10.0.0.0/16;
        deny all;
}

location /cc {
        try_files $uri $uri/ @rewrite;
}

location @rewrite {
        rewrite ^/cc/(.+)$ /cc/index.php last;
        rewrite ^/(.*)$ /index.php?q=$1;
}

location ~ \.php$ {
        try_files $uri =404;
        fastcgi_pass    php_fpm;
        fastcgi_read_timeout 150;
        fastcgi_index index.php;
        fastcgi_split_path_info ^(.+?\.php)(|/.*)$;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
}
```

While we were futzing with the configs, we thought we'd try to get php logging errors to see where the issues were coming from. Avanti found that we could alter the php configs by adding specific directives to the `.bp-config` dir under [`php/php.ini.d`](https://docs.cloudfoundry.org/buildpacks/php/gsg-php-config.html#engine-configurations), so we added an [`error_log.ini`](https://www.php.net/manual/en/errorfunc.configuration.php#ini.error-log) directive, which paid off later on.

## PHP Tricks

At this point, we were trying to understand how the app loaded and why the app appeared to load blank pages. We followed the trail through the php as it loaded scripts and components. Avanti added "hello worlds" to each page so we assured ourselves the pages were in fact loading, there was just nothing to see. One thing we saw was an error that said `vce-config.php` did not exist (it was being referenced in the `initiate.php` script.) This was true--the repo had a `vce-config copy.php` but no file without copy appended. We copied that as `vce-config.php` and the error went away, although the pages still didn't load as expected.

Following the page loads, we got down to `class.page.php`, which loaded a query. We tried to see whether we could get anything to load without making a database query, but were unsuccessful. At this point we reached out to Dayton Alleman, the CC app developer.

Dayton clarified a few things for us. He said the vce-config copy we had was an example one that was out of date. Because it could contain sensitive info, they didn't include it in the repo. He also said that the site couldn't load the homepage without a database query. To move us forward, he sent us a sandbox db dump, a sandbox vce-config, and the sandbox nginx conf.

All changes made to the CC team's app in this effort can be found in a [branch called `rek-rl-cc-cloudgov-exp` on their repo](https://github.com/HSICC/OHSCC/compare/rek-rl-cc-cloudgov-exp).

## Database Loading

To load the database with what Dayton had sent us, I copied the sql dump to the Ansible/Nagios EC2 instance using scp (`scp -i myidentityfile -3 ~/Downloads/ccdump.sql centos@10.2.0.6:/home/centos/ccdump.sql`) because I had already installed the [cloudfoundry CLI (7)](https://docs.cloudfoundry.org/cf-cli/install-go-cli.html#pkg-mac) in the Ansible/Nagios machine. Then, using the instructions from cloud.gov docs to [export a database](https://cloud.gov/docs/services/relational-database/#access-the-data-in-the-database), I used the [`cf connect-to-service` plugin](https://github.com/cloud-gov/cf-service-connect#readme) to open an SSH tunnel from the Ansible/Nagios instance and run a mysql query using the port, host, username, password, and name (database name) it generated. This meant running a command similar to `mysql -h 127.0.0.1 -P 40742 -u urzzofrodm29u325 -p -f -D cgawsbrokerprodcz6fgyioasosi39 < ccdump.sql` in another window on the Ansible/Nagios instance. At the same time, I could connect to the db in a third window to watch the transfer's progress by running something similar to `mysql -h 127.0.0.1 -P 40742 -u urzzofrodm29u325 -p -D cgawsbrokerprodcz6fgyioasosi39` and then running MySQL commands.

I did not encounter any issues getting the dump into the database bound to my cc app instance.

## Final DB and PHP Configuration

Once the database was loaded, we started seeing new errors--issues with the database configuration and some php errors.

We could see errors in the php error log we had set up previously. It was telling us that certain extensions being used in the app were undefined. By adding them to a `PHP_EXTENSIONS` field in the `options.json`, we were able to resolve those errors.

We realized the database config values had to correspond to what was in the `vce-config.php`. Ultimately we would be loading these values from the database so that the config would stay up to date as environment variables changed, but for now we just wanted things to work as easily as possible. We grabbed the configs from the database itself and hardcoded them into the `vce-config`. The one thing that was tricky for us there was the `DB_HOST` field, which we didn't realize was the part of the AWS host address that did not include username, database name, or password. It ended up looking like this in the definition block:

```php
/* MySQL hostname */
if (isset($_SERVER['DB_HOST'])) {
    define('DB_HOST', $_SERVER['DB_HOST']);
} else {
    define('DB_HOST', 'cg-aws-broker-prodjnhj6kxuzsphavd.ci7nkegdizyy.us-gov-west-1.rds.amazonaws.com');
}
```

At this point, somewhat like magic, the site loaded! Unfortunately we had a hashed version of the access tokens so we were unable to log in. Later, Dayton shared the access token with me and made me a user so I could login, which indeed I did!

The majority of pages loaded without incident and you could interact as expected with the database.

I encountered three issues with pages loading.

For [https://cc.app.cloud.gov/reports](https://cc.app.cloud.gov/reports), there was an undefined variable that I did not look into:

```php
PHP Notice:  Undefined variable: summary_preset_id in /home/vcap/app/htdocs/vce-content/components/nestor_reports/nestor_reports.php on line 270
[18-Jan-2022 13:15:27 America/Los_Angeles] PHP Fatal error:  Uncaught Error: Class 'nestor_report_summaries_hscc' not found in /home/vcap/app/htdocs/vce-content/components/nestor_reports/nestor_reports.php:299
```

For [https://cc.app.cloud.gov/about](https://cc.app.cloud.gov/about), I got a banner that read `About component cannot be found on this server.`

Resources within the resource library (for example [https://cc.app.cloud.gov/resourcelibrary?resource_id=19903]( https://cc.app.cloud.gov/resourcelibrary?resource_id=19903)) had an error that said `eclkc.ohs.acf.hhs.gov refused to connect.`.

Dayton [explained these issues](https://acf-ohs.slack.com/archives/C02SA7X0R16/p1642543469009100?thread_ts=1642533934.006800&cid=C02SA7X0R16) with the following: "components must be present, activated, and added to a recipe to function. There are probably some discrepancies between the sandbox site and this one, with certain db entries out of place."

I think we could have resolved them with more time.

## Helpful Hints

To access long-term logs for your app, go to: [https://logs.fr.cloud.gov/app/home](https://logs.fr.cloud.gov/app/home).

To ssh into your app from the command line, `cf ssh appname`.

## Reference Pairing Sessions

[We did 10 pairing sessions!!!! They can be found labeled in order on Google Drive](https://drive.google.com/drive/folders/1xRfMnbbHNFX6OXVzs5bCw9A6n6p7sXp-?ths=true).
