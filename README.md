# README

1. downloading & renaming all the files into the vendor folder
  - fullcalendar-4.3.1 > packages > core > main.min.js => fullcalendar.min.js
  - fullcalendar-4.3.1 > packages > core > main.min.css => fullcalendar.min.css
  - fullcalendar-4.3.1 > packages > moment > main.min.js => moment.min.js

2. create the sample event scaffold
  - rails generate scaffold Event title:string description:text start_date:datetime end_date:datetime
  - rails db:migrate

3. didn't work, trying the gem again
