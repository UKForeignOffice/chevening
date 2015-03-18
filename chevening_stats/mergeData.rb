#Resources
require 'rubygems'
require 'csv'
require 'time'

captureTime = Time.now.utc.iso8601
constant1 = ENV["CHEVENING_CONSTANT1"] || "week"
appYear = ENV["CHEVENING_APP_YEAR"] || "2016"
constant2 = ENV["CHEVENING_CONSTANT2"] || "digital"
eligible_stats = []
ineligible_stats = []
withdrawn_stats = []
pass_prescreen_stats = []
fail_prescreen_stats = []

data = File.open('autoCapture.csv')
data2= File.open('autoCapture.csv')
data3 = File.open('autoCapture.csv')
data4 = File.open('autoCapture.csv')
data5 = File.open('autoCapture.csv')

stat1 = ENV["CHEVENING_STAT1"] || "Passed Pre-Screen Questions"
stat2 = ENV["CHEVENING_STAT2"] || "failed pre-screen questions"
stat3 = ENV["CHEVENING_STAT3"] || "eligible applications"
stat4 = ENV["CHEVENING_STAT4"] || "ineligible applications"
stat5 = ENV["CHEVENING_STAT5"] || "withdrawn applications"

columnHeader4 = ENV["CHEVENING_OUTPUT_COLUMN4"] || "Description"
columnHeader6 = ENV["CHEVENING_OUTPUT_COLUMN6"] || "Cumulative Stats"


CSV.foreach("configStats.csv") {|row| eligible_stats << row[0]}
CSV.foreach("configStats.csv") {|row| ineligible_stats << row[1]}
CSV.foreach("configStats.csv") {|row| withdrawn_stats << row[2]}
CSV.foreach("configStats.csv") {|row| pass_prescreen_stats << row[3]}
CSV.foreach("configStats.csv") {|row| fail_prescreen_stats << row[4]}

begin

#create an archive file for comparison to calculate weekly stats

  if File::file?('mergeCapture.csv')

    File.rename('mergeCapture.csv', 'archiveMergeCapture.csv')
  else
  end
  ineligible = CSV.parse(data, headers: :first_row).each_with_object([]) do |row, mergeData|
    if ineligible_stats.include? row[columnHeader4]
      mergeData << row[columnHeader6]
    end
  end
  ineligible = ineligible.map(&:to_i).inject(:+)

  eligible = CSV.parse(data2, headers: :first_row).each_with_object([]) do |row, mergeData2|
    if eligible_stats.include? row[columnHeader4]
      mergeData2 << row[columnHeader6]

    end
  end
  eligible = eligible.map(&:to_i).inject(:+)
  withdrawn = CSV.parse(data3, headers: :first_row).each_with_object([]) do |row, mergeData3|
    if withdrawn_stats.include? row[columnHeader4]
      mergeData3 << row[columnHeader6]

    end
  end
  withdrawn = withdrawn.map(&:to_i).inject(:+)
  pass_prescreen = CSV.parse(data4, headers: :first_row).each_with_object([]) do |row, mergeData4|
    if pass_prescreen_stats.include? row[columnHeader4]
      mergeData4 << row[columnHeader6]

    end
  end
  pass_prescreen = pass_prescreen.map(&:to_i).inject(:+)
  fail_prescreen = CSV.parse(data5, headers: :first_row).each_with_object([]) do |row, mergeData5|
    if fail_prescreen_stats.include? row[columnHeader4]
      mergeData5 << row[columnHeader6]

    end
  end
  fail_prescreen = fail_prescreen.map(&:to_i).inject(:+)
  
#append data rows to merge capture


  mergeCapture =File.open('mergeCapture.csv', 'a')
  mergeCapture.puts captureTime+","+constant1+","+appYear+","+stat1+","+constant2+","+pass_prescreen.to_i.to_s
  mergeCapture.puts captureTime+","+constant1+","+appYear+","+stat2+","+constant2+","+fail_prescreen.to_i.to_s
  mergeCapture.puts captureTime+","+constant1+","+appYear+","+stat3+","+constant2+","+eligible.to_i.to_s
  mergeCapture.puts captureTime+","+constant1+","+appYear+","+stat4+","+constant2+","+ineligible.to_i.to_s
  mergeCapture.puts captureTime+","+constant1+","+appYear+","+stat5+","+constant2+","+withdrawn.to_i.to_s
rescue
  archiveFile = 'archiveMergeCapture.csv'

ensure
  mergeCapture.close unless mergeCapture.nil?
  archiveFile.close unless archiveFile.nil?
end
