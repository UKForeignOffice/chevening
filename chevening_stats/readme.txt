Read Me - Chevening Stats


Chevening_Stats script will scrape statistical data from extracted Chevening web page reports using Nokogiri ruby gem.
The data is merged and calculated to create a final stats csv file that contains the amalgamated data for the Chevening Automatic Application Report and Chevening Automatic Pre-Screening Report.

Installing Ruby

Nokogiri gem is used for stats scrape. Open command prompt from chevening_stats folder and enter: 

bundle install

Configuration

Many things can be set in environment variables to override the default settings if say a stat needs its description changed.

Run

To run script - navigate to the containing folder and using a command prompt enter
bundle exec ruby runStats.rb

runStats.rb controls the scripts being called, removes the temporary files and timestamps the persistent archive and output files.
autoStats.rb extracts the statuses and their counts from the saved report files.
mergeData.rb sums the status counts for their corresponding stats.
compare_stats.rb determines the weekly change in the stats.
weeklyStats_csv.rb creates the output file.


The csv file(s) will be output to the containing folder. finalStats_YYYYMMDD.csv is the completed file.

configStats.csv may be amended using Excel to alter descriptions included in each status. Do not delete or rename this file.
archiveMergeCapture.csv holds the latest previous cumulative stats, it is renamed to containa date stamp before being overwritten by the mergeCapture.csv file.
mergeCapture.csv holds the cumulative stats for the current extraction.

NOTE: If you need to correct a previous stat value prior to running the script, make the changes in the mergeCapture.csv file.
