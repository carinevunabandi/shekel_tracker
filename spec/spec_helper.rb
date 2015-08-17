ENV['RACK_ENV'] = 'test'

require File.expand_path('../../shekel_tracker.rb', __FILE__)

require 'capybara/rspec'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  ShekelTracker
end
