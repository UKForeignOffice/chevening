Read Me - Report Capture

Report Capture script will naviagate the Chevening admin website and save the html for the Application Report and Pre-Screening Report pages.

Installing Ruby

Capybara, rspec, poltergeist and Selenium-Webdriver gems are used for automated use of the website: 

bundle install

Configuration

Many things can be set in environment variables to override the default settings if say a link used has its label changed.
The 2 key environment variables to set though are CHEVENING_USERNAME and CHEVENING_PASSWORD which are used to access the secure admin website.

Run

To run script - navigate to the containing folder and using a command prompt enter
bundle exec rspec

The report files will each be generated with a date stamp.

Note: poltergeist can sometimes fail to connect to a URL, in which case run it again as it does not appear to fail twice in a row.