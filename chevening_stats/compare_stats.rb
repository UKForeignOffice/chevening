#Resources
require 'rubygems'
require 'csv'
begin
#variables
#variable to create compare data file and open/write to

  compareData = File.open("compareData.csv", "w")
  col_data_new = []
  col_data_old = []

#iterates through each 'row' in file and inputs data from array index 5 into variable
  CSV.foreach("mergeCapture.csv") {|row| col_data_new << row[5]}
  CSV.foreach("archiveMergeCapture.csv") {|row| col_data_old<< row[5]}

#zip arrays to read data across in rows
  col_data_new.zip(col_data_old).each do |col_data_new, col_data_old|

    compareData.puts  col_data_new+", "+ col_data_old

  end
ensure
  compareData.close unless compareData.nil?
  end