ENV['RACK_ENV'] = 'test'

require File.expand_path('../../../shekel_tracker.rb', __FILE__)

require 'byebug'
require 'capybara/cucumber'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

Before do
  DatabaseCleaner.clean
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end

Capybara.app = ShekelTracker
