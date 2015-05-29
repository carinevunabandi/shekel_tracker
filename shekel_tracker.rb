require 'bundler'
Bundler.require
require 'byebug' if development?
require 'sinatra'

class ShekelTracker < Sinatra::Base
  Dir[File.join(Sinatra::Application.root, 'app', 'controllers', '*.rb')].each { |f| require f }
  Dir[File.join(Sinatra::Application.root, 'app', 'models',      '*.rb')].each { |f| require f }

  set :views, proc { File.join(Sinatra::Application.root, 'app', 'views') }
end
