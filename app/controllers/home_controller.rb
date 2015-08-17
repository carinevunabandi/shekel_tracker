class ShekelTracker < Sinatra::Base

  get '/' do
    erb :'home/show'
  end
end
