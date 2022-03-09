<!-- mdformat-toc start --slug=github --no-anchors --maxlevel=6 --minlevel=1 -->

- [How to manage Qualys](#how-to-manage-qualys)
  - [Adding a new user to Qualys](#adding-a-new-user-to-qualys)
  - [Running a Qualys scan](#running-a-qualys-scan)
    - [How to run an OS scan](#how-to-run-an-os-scan)
    - [How to run an application scan](#how-to-run-an-application-scan)
  - [Retrieving scan results](#retrieving-scan-results)
    - [Archive OS scan results](#archive-os-scan-results)
    - [Archive Web Application scan results](#archive-web-application-scan-results)

<!-- mdformat-toc end -->

# How to manage Qualys

Qualys is a 3rd party website scanning tool.
This allows the OHS hosting team to run high quality security scans against the ECLKC envrionment without waiting on cycles from ACF OCIO.

## Adding a new user to Qualys

1. Login to the [Qualys Web portal][1].
1. From the "Modules" drop down menu, select "Utilities: Administration".
1. Click the dropdown button labelled "Create User" and select "Create Manager User".
1. This opens a popup where you'll enter in their name and email address. The other fields can be changed by the user later. Click "Save". The user should receive an email with a sign up link. Note the url in the email is only good for 24 hours.
1. Notify the user and ask them to go through the signup process and confirm with you they have access.

## Running a Qualys scan

There are two types of scans that are typically run from Qualys, an OS scan that checks the actual machines and an application scan that runs against the actual websites.

1. Login to the [Qualys Web portal][1].

### How to run an OS scan

1. Click on "VMDR".
1. Click on "Scans" from the tabs at the top.

If there has already been a scan run that targets the machines you need scanned, select that from the list and choose Relaunch from the Quick Action dropdown next to the scan name

If you would like to configure and launch a new scan:

1. Click the New button and select "EC2 Scan"
1. Input a meaningful name.
1. In the Options Profile dropdown, select "New Scan".
1. In the Connector dropdown, select "New ECLKC".
1. For Platform, select "EC2-VPC (All VPCs in Region)".
1. In the Available Regions dropdown, select "US East (N. Virginia)".
1. Click Add Tag and select "ECLKC Asset Group - EAST" in the dialog and click outside dialog to close.
1. In the Scanner Appliance dropdown, select "ECLKC_Scanner".
1. Click the checkbox for "Send Notification when scan is finished".
1. Click Launch.
1. Wait for machines to be populated in window, and then click Launch.

You should receive an email once the scan is completed.

### How to run an application scan

1. Click on "Web Application Scanning".
1. Click on "Scans" from the tabs at the top.

If there has already been a scan run that targets the machines you need scanned, select that from the list and choose "Scan Again" from the Quick Action dropdown next to the scan name.

If you would like to configure and launch a new scan:

1. Click "New Scan" and select "Vulnerability Scan".
1. Input a meaningful name.
1. In Web Applications dropdown, select "ECLKC Site" or "Early Educator Central" and click Continue.
1. In the Option Profile dropdown, select "ECLKC Scan Profile" for scanning ECLKC or "EEC" for scanning Early Educator Central.
1. Leave other options unchanged and click Continue.
1. Click Finish in next screen.

You should receive an email once the scan is completed.

## Retrieving scan results

### Archive OS scan results

1. Login to the [Qualys Web portal][1].
1. Click on "VMDR".
1. Click on the "Scans" tab.
1. Click on "Manage Vulnerability Scans".
1. Find the scan you want on the list. Hover the cursor over it and press the button to activate the context menu. Click on "Download" and choose PDF format.
1. Upload the PDF to the [Scan Results folder][2] on Box.
1. Name the file according to the scheme `Vuln_Scan_Results_YYYYMMDD.pdf` using the date the scan was run.

### Archive Web Application scan results

1. Login to the [Qualys Web portal][1].
1. Click on "Web Application Scanning".
1. Click on the "Scans" tab.
1. Find the scan you want on the list. Click on the blue "View Report" button.
1. Click on the "Download" button and choose PDF format. Click "Save".
1. Go make a cup of coffee. The progress bar is a lie.
1. Upload the PDF to the [Scan Results folder][2] on Box.
1. Name the file according to the scheme `ECLKC_Scan_Report_YYYYMMDD.pdf`.

[1]: https://qualysguard.qg3.apps.qualys.com/portal-front/
[2]: https://app.box.com/folder/143269631989
