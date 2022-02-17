# How to clean up mail on the mailserver

The `headstart@eclkc.info` email is monitored and forwarded by automation in the eclkc site.
The devs may or may not have direct access to manage the email box so the headstart hosting team may need to help out every so often.

## Check mailbox quotas

The mailbox quotas are reflected in the web ui but may not be updated quick enough while you're trying to free up space.
To check quotas on the server, ssh to the mailserver.

To check the quota limits for the email address use:

`doveadm quota get -u headstart@eclkc.info`

To recalculate quota limits for the user:

`doveadm quota recalc -u headstart@eclkc.info`

You will likely need to recalculate the quota after expunging emails from the different mailbox folders.

## Remove old junk from mailbox

To do this as the mail admin and not as the user, ssh to the mailserver.

To check the different folders in the mailbox for the user:

`doveadm mailbox list -u headstart@eclkc.info`

To delete mail in the Junk box:

`doveadm expunge -u headstart@eclkc.info mailbox Junk all`

To delete mail in the Trash box older than this week:

`doveadm expunge -u headstart@eclkc.info mailbox Trash before 1w`

You may need to run similar comands on other mailboxes.
