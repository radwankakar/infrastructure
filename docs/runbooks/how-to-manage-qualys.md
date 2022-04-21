<!-- mdformat-toc start --slug=github --no-anchors --maxlevel=6 --minlevel=1 -->

- [How to manage Qualys](#how-to-manage-qualys)
  - [Technical deployment of Qualys](#technical-deployment-of-qualys)
  - [Adding a new user to Qualys](#adding-a-new-user-to-qualys)
  - [Manually running a Qualys scan](#manually-running-a-qualys-scan)
    - [How to run an OS scan](#how-to-run-an-os-scan)
    - [How to run an application scan](#how-to-run-an-application-scan)
  - [Retrieving scan results](#retrieving-scan-results)
    - [Archive OS scan results](#archive-os-scan-results)
    - [Archive Web Application scan results](#archive-web-application-scan-results)
    - [CSV export of scan results](#csv-export-of-scan-results)
  - [Triaging scan results](#triaging-scan-results)
    - [Filter results](#filter-results)
    - [Triage results](#triage-results)
    - [Creating Jira tickets](#creating-jira-tickets)

<!-- mdformat-toc end -->

# How to manage Qualys

Qualys is a 3rd party vulnerability scanning tool.

This allows the OHS hosting team to run high quality security scans against the ECLKC environment (both servers and web applications) without waiting on cycles from ACF OCIO.

## Technical deployment of Qualys

There is an EC2 instance in the OHS AWS account that hosts the Qualys virtual scanner and connects the [Qualys Web portal][1] with systems in the AWS environment.

The virtual scanner uses ssh to reach and scan hosts for vulnerabilities. This is all configured through the [Qualys Web portal][1] (see Scans/Appliances and Scans/Authentication in the web portal).

## Adding a new user to Qualys

1. Login to the [Qualys Web portal][1].
1. From the "Modules" drop down menu, select "Utilities: Administration".
1. Click the dropdown button labelled "Create User" and select "Create Manager User".
1. This opens a popup where you'll enter in their name and email address. The other fields can be changed by the user later. Click "Save". The user should receive an email with a sign up link. Note the url in the email is only good for 24 hours.
1. Notify the user and ask them to go through the signup process and confirm with you they have access.

## Manually running a Qualys scan

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
1. Name the file according to the scheme `ECLKC_Scan_Report_YYYYMMDD.pdf` using the date the scan was run.

### CSV export of scan results

1. Login to the [Qualys Web portal][1].
1. Click on "VMDR".
1. Click on the "Vulnerabilities" tab.
1. Click on the "Download" icon on the far right of the screen
1. Select the fields you want or leave all fields checked. The only download format available should be CSV. Click on "Download".

## Triaging scan results

While the [Qualys Web portal][1] can be used to view and examine findings, it is often much easier to download a CSV of existing vulnerabilities and import it into Google Sheets to enable quick filtering and organization. Doing this can also make it easier to create Jira tickets for new vulnerabilities.

### Filter results

1. Load CSV export into Google Sheets
1. With the header row highlighted, select the _Data_ menu and the _Create a Filter_ option
1. Filter the data based on the _LAST DETECTED_ and _FIRST DETECTED_ columns to show only results from the scan you want to examine

### Triage results

These are general recommendations for helping assess and triage the results.

- Depending on the number of results, it is worth sorting vulnerabilities by _CVE_, _Title_, _Severity_, and/or _Asset Name_ to help assess how the vulnerabilities should be managed in Jira tickets.
- It's worth looking for patterns for CVEs/findings, such as groups of systems that share a CVE (some may apply to a number of systems or even all systems) or if a specific system has a number of CVEs/findings that might be interrelated.
  - It may make sense to group some results together rather than create specific tickets for each result -- this is a judgement that should be made during this initial triage/analysis.
- The _QID_ is the Qualys ID and for results that don't have a specific CVE tied to them, it can be helpful in looking up the scan results on Qualys itself.

### Creating Jira tickets

1. Create an epic every month for the Qualys scan results
   - Example: "2022-03 - Qualys Scan Results"
1. Create a Jira ticket within the appropriate epic
1. Prefix all ticket summaries with one of the following:
1. CVE-#
   - Example: "CVE-2021-44832 Update Jenkins for log4j"
1. Sometimes a collection of CVEs for a specific server may be all interrelated, and it doesn’t necessarily make sense to have a separate ticket for each CVE for that system. For example, a cluster of Kernel Advisories for a specific system where the old kernels need to simply be cleaned from the system. In cases like this, consider prefixing the ticket with "CVE-\*".
   - Example: "CVE-\* Kernel Security Advisories for ZTT-NAT"
1. EOL
   - Example: "EOL Migrate Server X from Ubuntu16 to Ubuntu18"
1. Add a label called "qualys"
1. Update the priority on the ticket to match the _Severity_ of the finding in Qualys - for example, severity of 5 would be the highest priority.

[1]: https://qualysguard.qg3.apps.qualys.com/portal-front/
[2]: https://app.box.com/folder/143269631989
