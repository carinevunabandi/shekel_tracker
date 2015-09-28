puts "Loading #{ENV['RACK_ENV']} seed"
env_seed = File.expand_path("#{ENV['RACK_ENV']}_seed.rb", __dir__)
load env_seed if File.exist? env_seed
puts "Done"
