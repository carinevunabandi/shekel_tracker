require 'bundler'
Bundler.require
require 'byebug' if development?
require 'sinatra'

class ShekelTracker < Sinatra::Base
  Dir[File.join(Sinatra::Application.root, 'app', 'controllers', '*.rb')].each { |file| require file }
  Dir[File.join(Sinatra::Application.root, 'app', 'models',      '*.rb')].each { |file| require file }
  Dir[File.join(Sinatra::Application.root, 'app', 'facades',      '*.rb')].each { |file| require file }

  enable :sessions
  register Sinatra::Flash

  set :views, proc { File.join(Sinatra::Application.root, 'app', 'views') }
end
