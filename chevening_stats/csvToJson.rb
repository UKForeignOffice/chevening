#Resources
require 'rubygems'
require 'json'
require 'csv'

file_name="finalStats.csv"


File.open("#{file_name}.json", "w") do |f| 

f.write(
	CSV.open(file_name, headers: true, header_converters: :symbol, converters: :all) do |csv|
	
	csv.to_a.map(&:to_hash).to_json
	end)

end