# Hosted Apps

Up to date as of 06/21
This is a list of all the applications we host and their associated team names. It was derived from all the EC2 instances running in AWS.

instance id and reservation id associated
then examine the reservation

| Name                    | Instance ID         | Instance Type | Environment     | Team               | Notes                                                                  |
|-------------------------|---------------------|---------------|-----------------|--------------------|------------------------------------------------------------------------|
| NAT                     | i-bb37664b          | m3.medium     | Prod            | Hosting            | Network address translation for private subnets                        |
| Tomcat1                 | i-2129e5f6          | m4.xlarge     | Prod            | HSICC              | Tomcat applications, CAS, and user management                          |
| Tomcat2                 | i-569c4881          | m4.xlarge     | Prod            | HSICC              | Tomcat applications                                                    |
| LDAP                    | i-aa7ea47d          | m3.medium     | Prod            | Hosting            | LDAP production server                                                 |
| LifeboatDB              | i-280ab0ff          | t2.medium     | Prod            | Maybe Hosting      | MariaDB server for Lifeboat                                            |
| Lifeboat                | i-59e72a8f          | c4.xlarge     | Prod            | Maybe Hosting      | Read-only failover server                                              |
| MobileApp-Locator       | i-bf790f16          | c4.large      | Prod            | Zero to Three      | Locator Server for Mobile App (older versions)                         |
| Varnish1                | i-000fdb72b354c657f | m4.xlarge     | Prod            | HSICC              | Drupal production server - Varnish, nginx, PHP                         |
| Varnish2                | i-010150920ef5ba340 | m4.xlarge     | Prod            | HSICC              | Drupal production server - Varnish, nginx, PHP                         |
| ParadisoLMS-Dev         | i-0af1141527e007e94 | c5.xlarge     | Dev and Staging | iPD                | LMS development and staging server                                     |
| Solr                    | i-0be22e9146187ec0a | r4.xlarge     | Prod            | HSICC              | Solr production server                                                 |
| Solr-Dev                | i-08a4f0724332af749 | c4.xlarge     | Staging         | HSICC              | Solr development and staging server                                    |
| CoachingCompanion       | i-0c6c089d0f7800dcf | m4.large      | Prod            | Coaching Companion | Coaching companion production server                                   |
| CoachingCompanion-Dev   | i-01d2c4a49ffea98a2 | t2.micro      | Staging         | Coaching Companion | Coaching companion staging server                                      |
| VPN                     | i-0d1afc4a953659c60 | m3.medium     | misc            | Hosting            | OpenVPN                                                                |
| ECLKCDev                | i-0847e3f510888f9bf | m4.2xlarge    | Dev             | Hosting            | ECLKC Drupal development integration and staging server                |
| DrupalDemo1             | i-01a7d791df7fa5b13 | t2.micro      | Staging         | HSICC              | Demo server                                                            |
| DrupalDemo2             | i-075faea7f1608b0e6 | t2.micro      | Staging         | HSICC              | Demo server                                                            |
| DrupalDemo3             | i-03ab1e383dd0d7768 | t2.micro      | Staging         | HSICC              | Demo server                                                            |
| Mail                    | i-020e9ef07298c8b0e | m4.large      |                 | Hosting            | Mail production server                                                 |
| Jenkins                 | i-039a5a550d221c88f | c4.large      |                 | HSICC              | Jenkins server for automated tasks                                     |
| SFTP                    | i-090980b098659acfc | t2.micro      |                 | Hosting            | SFTP server for developer access to Drupal-related files               |
| Ansible-Nagios          | i-0a4fdf046f3f65f40 | t2.medium     |                 | Hosting            | Ansible configuration management and Nagios monitoring                 |
| ZTT-Notifications-Dev   | i-080050c40495fd67e | t3.micro      | Dev             | Zero to Three      | Zero to three notifications staging server                             |
| ZTT-Notifications       | i-0ceab680e61101e4e | t3.micro      | Prod            | Zero to Three      | Zero to three notifications production server                          |
| ZTT-Apps-Dev            | i-02364bce86ac01473 | m4.large      | Dev             | Zero to Three      | Zero to three staging mobile apps                                      |
| ZTT-Apps                | i-0cebb7cbc4661bc24 | m4.large      | Prod            | Zero to Three      | Zero to three production mobile apps                                   |
| ZTT-NAT-Dev             | i-0a4b60f937c50a3d3 | t3.micro      | Dev             | Zero to Three      | Zero to three staging NAT server                                       |
| ZTT-NAT                 | i-07ff7ba294fed4a88 | t3.micro      | Prod            | Zero to Three      | Zero to three production NAT server                                    |
| Qualys                  | i-0a3d00ba2b2f9fc54 | t2.medium     |                 | HSICC              |                                                                        |
| InjuryIllness           | i-0ffd5609ef36a8230 | t3.medium     | Prod            | NCHBHS             | Injury and Illness production server (Treat as on hiatus--not running) |
| InjuryIllness-Dev       | i-083825550365fed45 | t2.micro      | Staging         | NCHBHS             | Injury and Illness staging server (Treat as on hiatus--not running)    |
| EEC                     | i-09818b71f995f1e80 | t2.medium     | Prod            | Zero to Three      | Early educator central production server (Low usage)                   |
| EEC-Dev                 | i-0475cb18a2c1cdf34 | t2.small      | Dev             | Zero to Three      | Early educator central staging server (Low usage)                      |
| IDS-Logs                | i-0aa24513d73ac3500 | c4.xlarge     |                 |                    | Intrusion detection and log server (deprecated)                        |
| MariaDB                 | i-0d8b2df4c9861788f | m4.xlarge     |                 | HSICC              | Production MariaDB server                                              |
| Stage                   | i-080d1086bcdb454cd | m4.large      |                 | HSICC              | Staging CAS and Tomcat Apps                                            |
| Stage1                  | i-051e015f378cf0090 | m4.large      |                 | HSICC              | Staging frontend server (Drupal)                                       |
| Stage2                  | i-088b46ff602644bdd | m4.large      |                 | HSICC              | Staging frontend server (Drupal)                                       |
| ParadisoLMS-autoscaling | i-0347cd25f2492e522 | m5a.xlarge    | Prod            | iPD                | Production IPD LMS server                                              |
