## Sprint 7

Meeting|Guan Wei|Xue Yong
---|---------|----------
To-do|Finalise documentation for testings, prepare app for stable release, add MCQ, add additional root-level repository in firebase to support reminders, f|Finalise documentation for testing, provide support for new front-end features, fix bugs that crop up from testing
13/07/20|Allow user to set additional reminders for quiz and view the current reminders set|Added links and quiz reference to notifications to support future releases.
14/07/20|Added quiz overview page that user can access from Explore page. Allow user to delete quiz reminders in the view reminders set dialog. The list of reminders in the dialog is then updated real-time.|Fixed a logging bug where certain logs could not be sent
15/07/20|Added private function in quiz creation; quiz can now be set to private. Added leaderboard in "View past results" of quiz. Deleting quiz now removes all the its reminders too.|Fixed a bug where notifications were being sent every 30seconds after an upload
16/07/20|Added set reminder and change reminder for task. Deleting task will remove its reminder too. Redesigned module information. Added new dialog to warn user of incorrect email/password. Fix timezone issues in date picker|Added task and quiz reminders that will be sent at the user specified task
17/07/20|Added MCQ type. Quiz overview in Explore, Quiz attempt page and quiz result page now support MCQ too|Started application testing to check for bugs
18/07/20|Bug fix for quiz deletion and module deletion. If the author deletes its quiz, the quiz will be redacted from users who have added it in too. When a module is deleted, its quizzes, tasks and reminders are cleared too.|Performed testing on the application.
19/07/20|Added function at a glance. At a glance will display the upcoming quiz and task reminder. Added new dialog screens to prompt user to set reminders minimum 1 hour from now. Added form field validation for all essential fields. Finalise testing documentation|Performed testing on the application and discovered certain bug.

### Sprint review and retrospective
Next week should mainly focus on delivering the product to the target audience and understand how they feel about it and consolidate they suggestions for future extension.
