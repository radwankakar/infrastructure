# Head Start ECLKC (HSICC) Integrations

## Background

As part of understanding the current system, we need to document all the current integrations and applications that are functional on the system so that we can include them when considering design, implementation, and migration to the new system. This will also help us when it comes to evaluating applications suitability for Cloud.gov.
This doc's contents is mostly cribbed from a doc by Sam Nevares of the HSICC team.

## Integrations

<span style="color:blue">**BACKEND**</span> indicates the application or service is backend.
<span style="color:orange">**FRONTEND**</span> indicates the application or service is frontend.

### CAS

Runs in a Tomcat 9 server in `tomcat1.east.eclkc` (10.0.0.21)

* Connects to LDAP <span style="color:blue">**BACKEND**</span>
* Connects to User Management <span style="color:orange">**FRONTEND**</span>
* Services <span style="color:blue">**BACKEND**</span> <span style="color:orange">**FRONTEND**</span>
  * IPD
  * IPD Stage
  * IPD SCORM
  * IPD SCORM Dev
  * IPD SCORM Prod
  * Coaching Companion
  * Box
  * Mail Inquiries
  * User Management
  * Injury and Illness
  * iLookOut
  * Drupal ECLKC
  * Drupal ECLKC Dev
  * Drupal ECLKC Stage
  * Drupal ELCKC Prod (Varnish 2)
  * Drupal Demo 1, 2 and 3

### User Management

This is a ExpressJS application running in a NodeJS server using React in the front-end.

* Connects to LDAP (10.0.1.40) <span style="color:blue">**BACKEND**</span>
* User authenticated via CAS <span style="color:blue">**BACKEND**</span> <span style="color:orange">**FRONTEND**</span>
* [Handles PIV Login](https://secure.eclkc.ohs.acf.hhs.gov)
* [Connects to HSES cloud.gov](https://piv-hses-ohs-acf-hhs.app.cloud.gov) <span style="color:blue">**BACKEND**</span>
* Connects to hses-oauth, which is a ExpresJS NodeJS application running in Varnish 1. <span style="color:blue">**BACKEND**</span>
* Sends emails through SES (email-smtp.us-east-1.amazonaws.com) using TLS. <span style="color:blue">**BACKEND**</span>
* Alternatively it sends emails through the Mail Server (mail.eclkc.info). <span style="color:blue">**BACKEND**</span>
* Uses user_mgmt MariaDB database in the MariaDB server (10.0.1.77). <span style="color:blue">**BACKEND**</span>

### HSES-Oauth

This is a ExpressJS application running in a NodeJS server in Varnish 1 using React in the front-end.

* Uses hses_oauth MariaDB database in the MariaDB server (10.0.1.77). <span style="color:blue">**BACKEND**</span>
* Sends emails using SMTP through the Mail server (mail.east.eclkc). <span style="color:blue">**BACKEND**</span>
* [Connects to HSES](https://hses.ohs.acf.hhs.gov) <span style="color:blue">**BACKEND**</span>

### ECLKC Drupal 9

Runs in a Nginx server in Varnish1 and Varnish2. The traffic is routed from the Varnish instance in the same servers (it doesn’t auto scale). Uses a MariaDB database in the MariaDB server (10.0.1.77).

* User authentication is done via CAS. User authorization is managed by Drupal, mapping CAS attributes (that are groups coming from LDAP0. <span style="color:blue">**BACKEND**</span> <span style="color:orange">**FRONTEND**</span>
* Purges and invalidates Varnish cache. <span style="color:blue">**BACKEND**</span>
* [Sends emails through SES](email-smtp.us-east-1.amazonaws.com) using TLS <span style="color:blue">**BACKEND**</span>
* Google Analytics and Site Improve scripts are embedded in all the pages <span style="color:orange">**FRONTEND**</span>
* Uses print friendly service to export pages to PDF. <span style="color:orange">**FRONTEND**</span>

Forms

* Connects to Google reCaptcha API <span style="color:blue">**BACKEND**</span> <span style="color:orange">**FRONTEND**</span>
* Resend Page for Public API Key Verification <span style="color:orange">**FRONTEND**</span>
  * HTTP POST request to `/eclkc-apis/apikeys/` resend-verification
* SignUp Page for API Key <span style="color:orange">**FRONTEND**</span>
  * HTTP POST request to `/eclkc-apis/apikeys/keys`
* Reset Page for API Key <span style="color:orange">**FRONTEND**</span>
  * HTTP POST request to `/eclkc-apis/apikeys/send-reset`
* Resend Page for Public API Key <span style="color:orange">**FRONTEND**</span>
  * HTTP POST request to `/eclkc-apis/apikeys/resend-key`
* Contact / Contact-Us
  * Sends confirmation email to the User. <span style="color:blue">**BACKEND**</span>
  * Sends notification email to site mail (admin@hsicc.org, headstart@eclkc.info). <span style="color:blue">**BACKEND**</span>
* Complaint
  * Send confirmation email to the User. <span style="color:blue">**BACKEND**</span>
  * Sends notification email to complaints@eclkc.info <span style="color:blue">**BACKEND**</span>
* Content Moderation
  * Sends emails using the Drupal SMTP config. <span style="color:blue">**BACKEND**</span>
* [NOFOs](https://eclkc.ohs.acf.hhs.gov/foa-condensed)
  * Backbone JavaScript app embedded in a Drupal module (foa_iframe).
  * Get status through a HTTP POST to [grants.gov](http://www.grants.gov) <span style="color:orange">**FRONTEND**</span>
  * `/foa-condensed` is embeded in an iframe in acf.hhs.gov/ohs/funding <span style="color:orange">**FRONTEND**</span>
  * `/foa-condensed` is embeded in an iframe in [ECLKC](https://eclkc.ohs.acf.hhs.gov/grant-application/article/notice-funding-opportunity-nofo-locator) <span style="color:orange">**FRONTEND**</span>
  * Attachments are stored in S3 <span style="color:orange">**FRONTEND**</span>
* [Grantee Service Profiles](https://eclkc.ohs.acf.hhs.gov/federal-monitoring/report/grantee-service-profiles )
  * Backbone JavaScript app embedded in a Drupal module (grantee_profiles).
  * Connects to Google maps API <span style="color:orange">**FRONTEND**</span>
  * Embedded iframe from [http://maps.google.com](http://maps.google.com) <span style="color:orange">**FRONTEND**</span>
  * Makes requests to `HSESReports1/PdfServlet` <span style="color:orange">**FRONTEND**</span>
* State Collaboration
  * `/api/eclkc-state-collaboration/` <span style="color:orange">**FRONTEND**</span>
* Translations
  * Connects bidirectionally to [Lingotek](https://gmc.lingotek.com) ([alternate Lingotek reference](https://myaccount.lingotek.com)) <span style="color:orange">**FRONTEND**</span> <span style="color:blue">**BACKEND**</span>
* Campaign Monitor
  * Connects to Campaign Monitor servlet using HTTP GET and POST requests `/CampaignMonitorDrupal/CampaignMonitorServlet`. <span style="color:blue">**BACKEND**</span>
* Mobile Services
* Center Locator
  * Backbone JavaScript application embedded in a Drupal module (head_start_center_locator).
  * Connects to Google Maps API <span style="color:orange">**FRONTEND**</span> <span style="color:blue">**BACKEND**</span>
  * Connects to Google Places API <span style="color:orange">**FRONTEND**</span> <span style="color:blue">**BACKEND**</span>
  * Connects to Express Locator API `/eclkc-apis/json-converter/convert` for CSV formatting. <span style="color:orange">**FRONTEND**</span>
  * Connects to Express Locator API `/eclkc-apis/locator/ center` for Geo-location data. <span style="color:orange">**FRONTEND**</span>
* Learning modules
  * Stored in S3 <span style="color:orange">**FRONTEND**</span>
* Search
  * Backbone JavaScript application embedded in a Drupal module (solr_search).
  * Makes HTTP GET requests to Solr `/solr/eclkc/hs_select` <span style="color:orange">**FRONTEND**</span>

### Express Locator API

### Solr

### Mail Inquiries

This is a ExpressJS application running in a NodeJS server using React in the front-end.

* Connects to LDAP (10.0.1.40) <span style="color:blue">**BACKEND**</span>
* User authenticated via CAS <span style="color:blue">**BACKEND**</span> <span style="color:orange">**FRONTEND**</span>
* Connect to MariaDB (10.0.1.77) <span style="color:blue">**BACKEND**</span>
* Connects to Solr (10.0.7.110) <span style="color:blue">**BACKEND**</span>
* Connect to JobTraq Servlet (`/JBTraq1/JBTraqServlet`) <span style="color:blue">**BACKEND**</span>. JobTraq servlet connect to HighGear using SOAP <span style="color:blue">**BACKEND**</span>
* Sends emails through SES (email-smtp.us-east-1.amazonaws.com) using TLS. <span style="color:blue">**BACKEND**</span>
* Alternatively it sends emails through the Mail Server (mail.eclkc.info). <span style="color:blue">**BACKEND**</span>
* It uses System Cron to retrieve emails from the configured email accounts using POP3. <span style="color:blue">**BACKEND**</span>
* It uses System Cron to fetch data from HighGear. <span style="color:blue">**BACKEND**</span>
* Stores attachments in the file system. <span style="color:blue">**BACKEND**</span> <span style="color:orange">**FRONTEND**</span>
