# List of processes we would like to automate 

## Goals and Action Items:

### Make Jenkins more secure and use to decrease technical toil 
* Move Jenkins behind the VPN: [OHSH-356](https://ocio-jira.acf.hhs.gov/browse/OHSH-356)
* Add additional Jenkins workers to execute jobs: [OHSH-778](https://ocio-jira.acf.hhs.gov/browse/OHSH-378)
* Document our standard for where we configure Jenkins jobs
* Create Jenkins jobs to run necessary yum commands as part of maintenance
* Automate testing in between above jobs as part of maintenance testing
* Write Jenkins job (using Ansible scripts) to switch varnish1 to point at lifeboat etc etc so we don’t need to support drupal deployments
* [Create a jenkins job to restart MariaDB server](https://ocio-jira.acf.hhs.gov/browse/OHSH-85)
### Make it easier to get instances to a known configuration
* Documentation on how to use Ansible
* Trigger specified updates on specific hosts
* Create user accounts/remove user accounts - document the process of removing user accounts. Audit which users exist on all the systems
* Create sudo access
* Management of user access on VPNs (east and west)
* Investigate automating logging configuration on hosts (including logrotate)
* Collect logs from all systems into CloudWatch 

### Make it so lifeboat and maintenance pages are easier to manage
* Write ansible jobs to keep Lifeboat up to date.
* Jenkins job to enable/disable maintenance pages (likely also leveraging ansible): [OSH-215](https://ocio-jira.acf.hhs.gov/browse/OHSH-215)

### Make it so we can make West match East
* Take AMI snapshots of East nightly + sync to West. (with cleanup) [OHSH-239](https://ocio-jira.acf.hhs.gov/browse/OHSH-239)
* Create a job to reconstitute West from ami snapshots

### Maintenance prep is automated
* Automatically run latest update on Stage and output report
