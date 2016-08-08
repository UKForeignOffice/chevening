require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'

appHostUrl = ENV["CHEVENING_APP_HOST_URL"] || "https://chevening.tal.net/"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  # Use Poltergeist by default - Runs Javascript and faster than Selenium-webdriver
  #Capybara.javascript_driver = :poltergeist
Capybara.configure do |config|
Capybara.default_wait_time = 10
  config.run_server = false
  config.app_host   = appHostUrl
end

Capybara.register_driver :selenium do |app|
  require 'selenium/webdriver'
  Selenium::WebDriver::Firefox::Binary.path = "/opt/firefox/firefox"
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

end
