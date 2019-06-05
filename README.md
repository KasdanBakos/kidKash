## 67-272: Chess Camp Solution to Phase 4 ##

This is a basic solution for the course project in 67-272: Application Design and Development.  This repo contains a solution only to Phase 4 of the project and can be used to start phase 5.

To set this up, clone this repository, run the `bundle install` command to ensure you have all the needed gems and then create the database with `rake db:migrate`.  If you want to populate the system with fictitious, but somewhat realistic data (similar to the data given in the spreadsheets in phase 1), you can run the `rake db:populate` command.  The populate script will create a series of curriculums, instructors and over 35 camps

Many objects are created with some element of randomness so you will get slightly different results each time it is run.  However, instructors and users are fixed.  If there were any users in this phase, all the users in the system have a password of 'secret'.  In terms of users there are two admins (Alex and Mark) and five instructor-level users (our five Head TAs).  The username for each will be their first name in all lowercase.

Instructions for what needs to be done in this phase of the project can be found in the project write-ups found on the [67-272 course site](http://67272.cmuis.net/projects/).


1. The list of registered students is only available for instructors teaching the camp.

2. Must enter password when making changes to own account as steps to authorize/authenticate(?) the user so no bad edits can be made. If password isn't entered then the change won't be committed as a security mesure.

3. Parents can read instructors, this is before registration because they'll want to know who's teaching their students

4. Made it so there's no option to add student to camp if family has no students associated with it

5. Made it so that the connected user is created at the same time as the instructor. This is to avoid any issues updating a user to a different role.

6. I did #5 for family as well.

7. Made it so that the drop down for assigning students to a camp (adding to cart) only shows students that don't have any conflicts, and aren't in the cart for that specific camp already

8. I have made it so that admins can delete registrations that have been paid for. This is because in the write up it says they can do everything, and I asked on Piazza and Jordan said it was up to me.

9. Admin can edit any account, don't touch or need the password though

10. List of registered students is shown on every camps page for family to see what students are already registered

11. You can't change the role of a user, must create them as a different type of account and delete the old one, accounts stay separate.

12. An admin can change a users password through the direct user account. Only used as a last attempt effort, like if the user forgot their password and wanted to regain access.

13. The data for the highcharts is faked. I tried to embed ruby into the chart but it wasn't rendering correctly, so I hard coded values in. Jordan said this was fine on Piazza. All of the other values are real values from the data in the system.

14. On dashboard for admin, shows the top 3 students by rank, and the number and which camps are active without an instructor. These are ordered by date.

15. I allow parent to read instructors, because I figure they want to know who is teaching their children. Asked on piazza about this and Jordan said it was up to me.

