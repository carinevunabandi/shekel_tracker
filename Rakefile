ENV['RACK_ENV'] ||= 'test'

require 'sinatra/activerecord/rake'

Dir[File.expand_path('../lib/tasks/**/*.rake', __FILE__)].sort.each { |r| load r }

require_relative './shekel_tracker.rb'
