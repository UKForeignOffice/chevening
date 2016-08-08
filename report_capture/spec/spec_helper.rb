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
  Capybara.javascript_driver = :webkit
Capybara.configure do |config|
  config.run_server = false
  config.app_host   = appHostUrl
end

Capybara.register_driver(:poltergeist) do |app|
    Capybara::Poltergeist::Driver.new app,
      js_errors: false,
      timeout: 300,
      logger: nil,
      phantomjs_options:
      [
        '--load-images=no',
        '--ignore-ssl-errors=yes'
      ]
  end
  # Uncomment this if you want to watch the tests
  # Capybara.javascript_driver = :selenium
end
