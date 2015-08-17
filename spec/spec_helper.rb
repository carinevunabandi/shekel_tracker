ENV['RACK_ENV'] = 'test'

require File.expand_path('../../shekel_tracker.rb', __FILE__)

require 'capybara/rspec'
require 'rspec'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  ShekelTracker
end
#Dir[File.join(Sinatra::Application.root, 'spec', 'support', '**', '*.rb')].each { |f| require f }
