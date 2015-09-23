if ENV['RACK_ENV'] != 'production'
  require 'rake/clean'

  CLEAN.include 'log/**'

  task default: [:clean, :rubocop, :sandi_meter, :spec, :'coverage:check_specs', :cucumber, :shekel_tracker_ok]
end
