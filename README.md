# Hyper Beam

An NUS Orbital 2020 independent software development  project.

## Introduction

## Features
1. Login Page\
  1.1 Create account with email verification\
  1.2 Login with account create from feature\
  1.3 Reset password\
  1.4 Sign in with Gmail\
  1.5 Log out\
  1.6 User stays logged in unless user chose to sign out
2. Task\
  2.1 Create task with button on Module Card\
  2.2 Set reminder\
  2.3 Change reminder\
  2.4 Delete task
3. Module Card\
  3.1 Module card can only be created with module codes that are in NUSMod API\
  3.2 Delete module and all of its content\
  3.3 Display the number of quizzes and task in it\
  3.4 Display course information based on NUSMod API
4. Quiz\
  4.1 Create quiz with button on Module Card\
  4.2 Create open-ended question\
  4.3 Create MCQ\
  4.4 Set reminders\
  4.5 Delete reminder and add reminders\
  4.6 View all reminders set for the quiz\
  4.7 View past results of the quiz\
  4.8 Leaderboard for the quiz\
  4.9 Delete quiz and all its content\
  4.10 Quiz result summary page and submit review for the quiz\
  4.11 Private quiz
5. At a glance\
  5.1 Show the upcoming reminder for task and quiz\
  5.2 View all reminders
6. Explore\
  6.1  Display all non-private quizzes real-time\
  6.2 View all information of the quiz\
  6.3 Add quiz to Module Card\
  6.4 Dynamic search bar to search for quizzes
7. PDF\
  7.1 Upload PDF from file manager/ One-drive/ G-drive\
  7.2 View and download all previously uploaded PDF files from the user\
  7.3  Preview PDF file and link it to relevant quizzes before uploading\
  7.4 Receive push notification once the master PDF is updated\
  7.5 Subscribe and unsubscribe to future updates from master PDF\
  7.6 View information on and download master PDF files after user upload similar PDF files\
  7.7 Receive master PDF where the highlights from all other users overlap with the highlights from the user.

## User flow

The user will set their own quizzes, and the answers to each question can be linked to the relevant section of a .pdf file through the use of annotations. 
Users can also check their highlights against their peers; after submitting their highlights, a new pdf will be available to them, where a darker shade would signify that a larger portion of our user highlighted that word. Quizzes can either be searched for, or set to appear when a user uploads a pdf containing information relevant to the quiz. A leaderboard can be implemented to ignite the competitive spirit of our students. 
Through this, we hope that users would be able to gauge their progress and refresh their memory of the subject periodically.

## Technology Stack
* Android Studio
* Flutter
* Dart
* Google Cloud Firebase
* Google App Engine Flexible Environment
* Google Cloud Logging
* Google Cloud Storage
* Google Cloud Tasks
* Google Cloud Scheduler
* Google Cloud Functions
* Google Pubsub
* Flask
* Gunicorn3
* Docker
* Python 3.7.3
* Ubuntu 18.04

