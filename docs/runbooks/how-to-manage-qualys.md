# How to manage Qualys

Qualys is a 3rd party website scanning tool.
This allows the OHS hosting team to run high quality security scans against the ECLKC envrionment without waiting on cycles from ACF OCIO.

## Adding a new user to Qualys

1. Login to the [Qualys Web portal][1].
2. From the "Modules" drop down menu, select "Utilities: Administration".
3. Click the dropdown button labelled "Create User" and select "Create Manager User".
4. This opens a popup where you'll enter in their name and email address. The other fields can be changed by the user later. Click "Save". The user should receive an email with a sign up link. Note the url in the email is only good for 24 hours.
5. Notify the user and ask them to go through the signup process and confirm with you they have access.

## Running a Qualys scan

There are two types of scans that are typically run from Qualys, an OS scan that checks the actual machines and an application scan that runs against the actual websites.

1. Login to the [Qualys Web portal][1].

### For OS scans
1. Click on "Vulnerability Management"
2. Click on "Scans" from the tabs at the top
3. If there has already been a scan run that targets the machines you need scanned, select that from the list and choose Relaunch from the Quick Action dropdown next to the scan name
4. If you would like to configure and launch a new scan:
   1.  Click the New button and select "EC2 Scan"
   2.  Input a meaningful name
   3.  In the Options Profile dropdown, select "New Scan"
   4.  In the Connector dropdown, select "New ECLKC"
   5.  For Platform, select "EC2-VPC (All VPCs in Region)"
   6.  In the Available Regions dropdown, select "US East (N. Virginia)"
   7.  Click Add Tag and select "ECLKC Asset Group - EAST" in the dialog and click outside dialog to close
   8.  In the Scanner Appliance dropdown, select "ECLKC_Scanner"
   9.  Click the checkbox for "Send Notification when scan is finished"
   10.  Click Launch
   11.  Wait for machines to be populated in window and then click Launch
5. You should receive an email once the scan is completed

### For application scans
1. Click on "Web Application Scanning"
2. Click on "Scans" from the tabs at the top
3. If there has already been a scan run that targets the machines you need scanned, select that from the list and choose "Scan Again" from the Quick Action dropdown next to the scan name
4. If you would like to configure and launch a new scan:
   1. Click "New Scan" and select "Vulnerability Scan"
   2. Input a meaningful name
   3. In Web Applications dropdown, select "ECLKC Site" or "Early Educator Central" and click Continue
   4. In the Option Profile dropdown, select "ECLKC Scan Profile" for scanning ECLKC or "EEC" for scanning Early Educator Central
   5. Leave other options unchanged and click Continue
   6. Click Finish in next screen
5. You should receive an email once the scan is completed

[1]: https://qualysguard.qg3.apps.qualys.com/portal-front/
