# encoding: utf-8
#Resources
require 'rubygems'
require 'nokogiri'
require 'csv'
require 'time'

#Variables and textfile connection paths

now = Date.today
monday = now - (now.wday - 1) % 7

constant1 = ENV["CHEVENING_CONSTANT1"] || "week"
appYear = ENV["CHEVENING_APP_YEAR"] || "2016"
constant2 = ENV["CHEVENING_CONSTANT2"] || "digital"
dateLabel = Time.now.strftime("%Y%m%d")

applicationReportFile = ENV["CHEVENING_APPLICATION_FILE"] || "ApplicationReport"
preScreeningReportFile = ENV["CHEVENING_PRE_SCREENING_FILE"] || "PreScreeningReport"
outputFileExtension = ENV["CHEVENING_OUTPUT_EXTENSION"] || ".html"
applicationReportPath = ENV["CHEVENING_APPLICATION_REPORT"] || "../report_capture/"+applicationReportFile+dateLabel+ outputFileExtension
preScreeningReportPath = ENV["CHEVENING_PRESCREENING_REPORT"] || "../report_capture/"+preScreeningReportFile+dateLabel+ outputFileExtension

columnHeader1 = ENV["CHEVENING_OUTPUT_COLUMN1"] || "Capture Date"
columnHeader2 = ENV["CHEVENING_OUTPUT_COLUMN2"] || "Constant 1"
columnHeader3 = ENV["CHEVENING_OUTPUT_COLUMN3"] || "Application Year"
columnHeader4 = ENV["CHEVENING_OUTPUT_COLUMN4"] || "Description"
columnHeader5 = ENV["CHEVENING_OUTPUT_COLUMN5"] || "Constant 2"
columnHeader6 = ENV["CHEVENING_OUTPUT_COLUMN6"] || "Cumulative Stats"

captureTime = monday.strftime('%Y-%m-%d') + "T00:00:00Z"
keystats = Array.new
cumulativeValues = Array.new
preKeyStats = Array.new
preCumulativeValue = Array.new

begin
#variable for capture files, open, write and append
  autoCaptureFile = File.open("autoCapture.csv", "a") #write to capture file
  appendCaptureFile = File.open("autoCapture.csv", "a") #append further stats from prescreen page

  CSV.open("autoCapture.csv", "w") do |csv| # open and write header row to CSV file
    csv<< [columnHeader1, columnHeader2, columnHeader3, columnHeader4, columnHeader5, columnHeader6]

  end
#Nokogiri connection to Report Filtered HTML file, scrape and output
  pageReport = Nokogiri::HTML(open(applicationReportPath))
  puts pageReport.class
  keystats = pageReport.xpath("//th[@scope='row']").collect { |node| node.text.strip }
  cumulativeValues = pageReport.xpath("//td[@class='middle-total-cell']").collect { |node| node.text.strip }
#puts stat from Reports page into autoCapture.txt

  keystats.zip(cumulativeValues).each do |keystats, cumulativeValues|
    autoCaptureFile.puts captureTime+","+constant1+","+appYear+",\""+keystats.delete('–')+"\","+constant2+","+cumulativeValues[0..-8]
  end

#Nokogiri connection to Pre-Screening HTML file, scrape and output
  pagePrescreen = Nokogiri::HTML(open(preScreeningReportPath))
  puts pagePrescreen.class
  preKeyStats = pagePrescreen.xpath("//th[@scope='row']").collect { |node| node.text.strip }
  preCumulativeValue = pagePrescreen.xpath("//td[@class='middle-total-cell']").collect { |node| node.text.strip }

#appends stats from preScreen file to autoCapture.txt
  preKeyStats.zip(preCumulativeValue).each do |preKeyStats, preCumulativeValue|
    appendCaptureFile.puts captureTime+","+constant1+","+appYear+",\""+preKeyStats.delete('–')+"\","+constant2+","+preCumulativeValue[0..-8]

  end

ensure
#close open resource files
  autoCaptureFile.close unless autoCaptureFile.nil?
  appendCaptureFile.close unless appendCaptureFile.nil?
end
