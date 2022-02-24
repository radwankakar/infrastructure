# Updating the Coaching Companion Staging Database

Every so often we have to replace the Coaching Companion staging database with the latest dump of the production database to keep the Dev and Staging sites up to date with the production site for testing and development purposes. Here's how:

- ssh into the mariadb server
- run the following command: `mysqldump --databases coaching-companion > [dump].sql` this should give you the desired backup file
- follow the above steps in the CoachingCompanion-Dev server, pointing at the `ncqtlcoachingdev` db, as well in order to backup the db there.
- then locally run the scp command, passing in your ssh credentials, in order to grab the sql file from the mariadb server: `scp -i [ssh creds] [remote username]@[remote ip address]:[path to desired file] [path to where you want the file locally]`
- once you've got the sql file locally open it and change any reference to `coaching-companion` to `ncqtlcoachingdev`
- next run the above scp again, just flipped, pointing at the CoachingCompanion-Dev instead of the mariadb server. sending the newly edited sql to the CoachingCompanion-Dev server: `scp -i [ssh creds] [dump].sql [remote username]@[remote ip address]:[path]`
- make your way back into CoachingCompanion-Dev and run the following command: `mysql ncqtlcoachingdev < [prod dump].sql` once that's done you've just updated the db!
- get in touch with the point of contact for the Coaching Companion app to get them a password-protected zipped version of the dump, as well as to ensure the switch went through on their end.
