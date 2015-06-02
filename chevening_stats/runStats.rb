#Resources
require 'rubygems'
require 'csv'
require 'time'
require 'date'
require 'fileutils'

now = Date.today
monday = now - (now.wday - 1) % 7

dateLabel = Time.now.strftime("%Y%m%d")
captureTime = monday.strftime('%Y-%m-%d') + "T00:00:00Z"
constant1 = ENV["CHEVENING_CONSTANT1"] || "week"
appYear = ENV["CHEVENING_APP_YEAR"] || "2015"
constant2 = ENV["CHEVENING_CONSTANT2"] || "digital"

begin
    directoryName = appYear.to_i-1
    if File.exists?(directoryName.to_s)
        #Do nothing
    else
        begin
            Dir.mkdir(directoryName.to_s)
            FileUtils.mv Dir.glob('*.csv'), './'+directoryName.to_s+'/'
            FileUtils.mv './'+directoryName.to_s+'/configStats.csv', './configStats.csv'
            FileUtils.mv Dir.glob('*.json'), './'+directoryName.to_s+'/'
        end
    end

    if File::file?('archiveMergeCapture.csv')
      File.rename('archiveMergeCapture.csv', 'archiveMergeCapture_'+dateLabel+'.csv')
    else
      begin
        newArchive =File.open('archiveMergeCapture.csv', 'a')
        newArchive.puts captureTime+","+constant1+","+appYear+","+"Passed pre-screen"+","+constant2+", 0"
        newArchive.puts captureTime+","+constant1+","+appYear+","+"Failed pre-screen"+","+constant2+", 0"
        newArchive.puts captureTime+","+constant1+","+appYear+","+"Eligible"+","+constant2+", 0"
        newArchive.puts captureTime+","+constant1+","+appYear+","+"Ineligible"+","+constant2+", 0"
        newArchive.puts captureTime+","+constant1+","+appYear+","+"Withdrawn"+","+constant2+", 0"
		newArchive.puts captureTime+","+constant1+","+appYear+","+"Invited to interview"+","+constant2+", 0"
		newArchive.puts captureTime+","+constant1+","+appYear+","+"Interview complete"+","+constant2+", 0"
		newArchive.puts captureTime+","+constant1+","+appYear+","+"Recommended for a scholarship"+","+constant2+", 0"
        newArchive.puts captureTime+","+constant1+","+appYear+","+"Total"+","+constant2+", 0"
      ensure
        newArchive.close unless newArchive.nil?
      end
    end

    if File::file?('totalStats.csv')
    else
      begin
        newArchive =File.open('totalStats.csv', 'a')
        newArchive.puts "0"
        newArchive.puts "0"
        newArchive.puts "0"
        newArchive.puts "0"
        newArchive.puts "0"
        newArchive.puts "0"
        newArchive.puts "0"
        newArchive.puts "0"
        newArchive.puts "0"
      ensure
        newArchive.close unless newArchive.nil?
      end
    end

    load "autoStats.rb"
    load "mergeData.rb"
    load "compare_stats.rb"
    load "weeklyStats_csv.rb"
	load "csvToJson.rb"
    puts "Script complete"
    puts "Final Stats csv created"

#Delete files for testing file generation
File.delete("./autoCapture.csv")
File.delete("./compareData.csv")
File.delete("./archiveTotalStats.csv")
File.rename('finalStats.csv.json', 'finalStats_'+dateLabel+'.json')
File.rename('finalStats.csv', 'finalStats_'+dateLabel+'.csv')
end
