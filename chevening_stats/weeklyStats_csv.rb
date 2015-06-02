#Resources
require 'rubygems'
require 'csv'
require 'base64'
require 'time'

col_date = []
col_constant1 = []
col_constant2 = []
col_appYear = []
col_statsDesc = []
weekly_total = []
cumulative_total = []
col_id = []

columnHeader1 = ENV["CHEVENING_OUTPUT_COLUMN1"] || "_timestamp"
columnHeader2 = ENV["CHEVENING_OUTPUT_COLUMN2"] || "period"
columnHeader3 = ENV["CHEVENING_OUTPUT_COLUMN3"] || "chevening_year"
columnHeader4 = ENV["CHEVENING_OUTPUT_COLUMN4"] || "stage"
columnHeader5 = ENV["CHEVENING_OUTPUT_COLUMN5"] || "channel"
columnHeader6 = ENV["CHEVENING_OUTPUT_COLUMN6"] || "cumulative"
columnHeader7 = ENV["CHEVENING_OUTPUT_COLUMN7"] || "count"
columnHeader8 = ENV["CHEVENING_OUTPUT_COLUMN8"] || "_id"

begin
#write to capture file, open and append
fname = "finalStats.csv"
finalStatsFile = File.open(fname, "a")

CSV.open("finalStats.csv", "w", headers:true) do |csv|# open and write header row to CSV file
	csv << [columnHeader1,columnHeader2,columnHeader3,columnHeader4,columnHeader5,columnHeader6,columnHeader7,columnHeader8]

end

#calculate weekly data by subtracting data at index 0 from index 1
CSV.foreach('compareData.csv', converters: :numeric) do |row|
	if row[0] > row[1]
	 weekly_total << row[0] - row[1] # add new weekly total to variable
	 cumulative_total << row[0] # this will be the new cumulative total 
	elsif row[0] < row[1]
		weekly_total << row[0] - row[0] # weekly total will be 0
		cumulative_total << row[1] # we just want to keep the old total as the new value is less
	else row[0] == row[1]
		weekly_total << row[0] - row[1] # weekly total will be 0
		cumulative_total << row[1]
	end
	
 end

 if File::file?('totalStats.csv')
      File.rename('totalStats.csv', 'archiveTotalStats.csv')
      begin
      	newFile =File.open('totalStats.csv', 'a')
 			cumulative_total.each do |i|
 				newFile.puts i
 			end
 	  ensure
        newFile.close unless newFile.nil?
      end
 else
 end

#retrieve stats from original document 
CSV.foreach("mergeCapture.csv") {|row| col_date << row[0]}
CSV.foreach("mergeCapture.csv") {|row| col_constant1 << row[1]}
CSV.foreach("mergeCapture.csv") {|row| col_appYear << row[2]}
CSV.foreach("mergeCapture.csv") {|row| col_statsDesc << row[3]}
CSV.foreach("mergeCapture.csv") {|row| col_constant2 << row[4]}
CSV.foreach("mergeCapture.csv") {|row| col_id << Base64.encode64(row[0]+row[1]+row[2]+row[3]+row[4])}

 #zip arrays to read data across as csv and append new weekly data stats
   col_date.zip(col_constant1, col_appYear, col_statsDesc, col_constant2, cumulative_total, weekly_total, col_id).each do |col_date, col_constant1, col_appYear, col_statsDesc, col_constant2, cumulative_total, weekly_total, col_id|
	 
	 
	 finalStatsFile.puts col_date+","+
						 col_constant1+","+ 
						 col_appYear+","+
						 col_statsDesc+","+
						 col_constant2+","+
						 cumulative_total.to_s+","+
						 weekly_total.to_s+","+
						 col_id.to_s.gsub!(/\s+/, "")

	 end
ensure
	finalStatsFile.close unless finalStatsFile.nil?

	end
