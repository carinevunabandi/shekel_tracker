ENV['RACK_ENV'] = 'test'

require File.expand_path('../../../shekel_tracker.rb', __FILE__)

require 'capybara/cucumber'

Capybara.app = ShekelTracker