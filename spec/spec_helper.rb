ENV['RACK_ENV'] = 'test'

require File.expand_path('../../shekel_tracker.rb', __FILE__)

require 'byebug'
require 'capybara/rspec'
require 'database_cleaner'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end

def app
  ShekelTracker
end
