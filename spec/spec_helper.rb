ENV['RACK_ENV'] = 'test'

require 'byebug'
require 'capybara/rspec'
require 'database_cleaner'
require 'simplecov'
require 'factory_girl'
require 'faker'

SimpleCov.start do
  add_filter '/spec'
  add_filter '/vendor'
  coverage_dir 'log/coverage/spec'
end

require File.expand_path('../../shekel_tracker.rb', __FILE__)

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods
  FactoryGirl.find_definitions

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end

def app
  ShekelTracker
end
