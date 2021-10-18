# Head Start ECLKC (HSICC) Integrations

## Background

As part of understanding the current system, we need to document all the current integrations and applications that are functional on the system so that we can include them when considering design, implementation, and migration to the new system. This will also help us when it comes to evaluating applications suitability for Cloud.gov.

## Integrations

### CAS

Runs in a Tomcat 9 server in `tomcat1.east.eclkc` (10.0.0.21)

* Connects to LDAP **BACKEND**
* Connects to User Management **FRONTEND**
* Services **BACKEND** **FRONTEND**
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

* Connects to LDAP (10.0.1.40) **BACKEND**
* User authenticated via CAS **BACKEND** **FRONTEND**
* [Handles PIV Login](https://secure.eclkc.ohs.acf.hhs.gov)
* [Connects to HSES cloud.gov](https://piv-hses-ohs-acf-hhs.app.cloud.gov) **BACKEND**
* Connects to hses-oauth, which is a ExpresJS NodeJS application running in Varnish 1. **BACKEND**
* Sends emails through SES (email-smtp.us-east-1.amazonaws.com) using TLS. **BACKEND**
* Alternatively it sends emails through the Mail Server (mail.eclkc.info). **BACKEND**
* Uses user_mgmt MariaDB database in the MariaDB server (10.0.1.77). **BACKEND**

### HSES-Oauth

This is a ExpressJS application running in a NodeJS server in Varnish 1 using React in the front-end.

* Uses hses_oauth MariaDB database in the MariaDB server (10.0.1.77). **BACKEND**
* Sends emails using SMTP through the Mail server (mail.east.eclkc). **BACKEND**
* [Connects to HSES](https://hses.ohs.acf.hhs.gov) **BACKEND**

### ECLKC Drupal 9

Runs in a Nginx server in Varnish1 and Varnish2. The traffic is routed from the Varnish instance in the same servers (it doesn’t auto scale). Uses a MariaDB database in the MariaDB server (10.0.1.77).

* User authentication is done via CAS. User authorization is managed by Drupal, mapping CAS attributes (that are groups coming from LDAP0. **BACKEND** **FRONTEND**
* Purges and invalidates Varnish cache. **BACKEND**
* [Sends emails through SES](email-smtp.us-east-1.amazonaws.com) using TLS **BACKEND**
* Google Analytics and Site Improve scripts are embedded in all the pages **FRONTEND**
* Uses print friendly service to export pages to PDF. **FRONTEND**

Forms

* Connects to Google reCaptcha API **BACKEND** **FRONTEND**
* Resend Page for Public API Key Verification **FRONTEND**
  * HTTP POST request to `/eclkc-apis/apikeys/` resend-verification
* SignUp Page for API Key **FRONTEND**
  * HTTP POST request to `/eclkc-apis/apikeys/keys`
* Reset Page for API Key **FRONTEND**
  * HTTP POST request to `/eclkc-apis/apikeys/send-reset`
* Resend Page for Public API Key **FRONTEND**
  * HTTP POST request to `/eclkc-apis/apikeys/resend-key`
* Contact / Contact-Us
  * Sends confirmation email to the User. **BACKEND**
  * Sends notification email to site mail (admin@hsicc.org, headstart@eclkc.info). **BACKEND**
* Complaint
  * Send confirmation email to the User. **BACKEND**
  * Sends notification email to complaints@eclkc.info **BACKEND**
* Content Moderation
  * Sends emails using the Drupal SMTP config. **BACKEND**
* [NOFOs](https://eclkc.ohs.acf.hhs.gov/foa-condensed)
  * Backbone JavaScript app embedded in a Drupal module (foa_iframe).
  * Get status through a HTTP POST to [grants.gov](http://www.grants.gov) **FRONTEND**
  * `/foa-condensed` is embeded in an iframe in acf.hhs.gov/ohs/funding **FRONTEND**
  * `/foa-condensed` is embeded in an iframe in [ECLKC](https://eclkc.ohs.acf.hhs.gov/grant-application/article/notice-funding-opportunity-nofo-locator) **FRONTEND**
  * Attachments are stored in S3 **FRONTEND**
* [Grantee Service Profiles](https://eclkc.ohs.acf.hhs.gov/federal-monitoring/report/grantee-service-profiles )
  * Backbone JavaScript app embedded in a Drupal module (grantee_profiles).
  * Connects to Google maps API **FRONTEND**
  * Embedded iframe from [http://maps.google.com](http://maps.google.com) **FRONTEND**
  * Makes requests to `HSESReports1/PdfServlet` **FRONTEND**
* State Collaboration
  * `/api/eclkc-state-collaboration/` **FRONTEND**
* Translations
  * Connects bidirectionally to [Lingotek](https://gmc.lingotek.com) ([alternate Lingotek reference](https://myaccount.lingotek.com)) **FRONTEND** **BACKEND**
* Campaign Monitor
  * Connects to Campaign Monitor servlet using HTTP GET and POST requests `/CampaignMonitorDrupal/CampaignMonitorServlet`. **BACKEND**
* Mobile Services
* Center Locator
  * Backbone JavaScript application embedded in a Drupal module (head_start_center_locator).
  * Connects to Google Maps API **FRONTEND** **BACKEND**
  * Connects to Google Places API **FRONTEND** **BACKEND**
  * Connects to Express Locator API `/eclkc-apis/json-converter/convert` for CSV formatting. **FRONTEND**
  * Connects to Express Locator API `/eclkc-apis/locator/ center` for Geo-location data. **FRONTEND**
* Learning modules
  * Stored in S3 **FRONTEND**
* Search
  * Backbone JavaScript application embedded in a Drupal module (solr_search).
  * Makes HTTP GET requests to Solr `/solr/eclkc/hs_select` **FRONTEND**

### Express Locator API

### Solr

### Mail Inquiries

This is a ExpressJS application running in a NodeJS server using React in the front-end.

* Connects to LDAP (10.0.1.40) **BACKEND**
* User authenticated via CAS **BACKEND** **FRONTEND**
* Connect to MariaDB (10.0.1.77) **BACKEND**
* Connects to Solr (10.0.7.110) **BACKEND**
* Connect to JobTraq Servlet (`/JBTraq1/JBTraqServlet`) **BACKEND**. JobTraq servlet connect to HighGear using SOAP **BACKEND**
* Sends emails through SES (email-smtp.us-east-1.amazonaws.com) using TLS. **BACKEND**
* Alternatively it sends emails through the Mail Server (mail.eclkc.info). **BACKEND**
* It uses System Cron to retrieve emails from the configured email accounts using POP3. **BACKEND**
* It uses System Cron to fetch data from HighGear. **BACKEND**
* Stores attachments in the file system. **BACKEND** **FRONTEND**
