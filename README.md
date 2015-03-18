# FCO-Chevening-Automation

## Automation for providing Chevening Application stats to the Government Performance Platform

This is effectively 3 utilities; Screening scraping from the Chevening Application site, processing the stats and upload to the performance platform..

The report capture produces 2 reports (Application report and Pre-Screening Report).
This can be run separately using "bundle exec rspec" in the report_capture directory.

The Chevening Stats extract the counts for the statuses in the reports, merges the counts for each stat, compares this with the previously stats and formats the output for upload to the performance platform. 
This can be run separately using "bundle exec ruby runStats.rb"  in the chevening_stats directory.


## Tests 
Testing for the report capture, chevening stats and performance platform upload should be performed manually.


## Deployment
The 3 stages should ideally be deployed as steps within Jenkins with notification emails on failure and success. The report capture should allow for a timeout failure and rerun.

