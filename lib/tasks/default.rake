if ENV['RACK_ENV'] != 'production'
  require 'rake/clean'

  CLEAN.include 'log/**'

  task default: [:clean, :rubocop, :spec, :'coverage:check_specs', :cucumber, :ok]
end
