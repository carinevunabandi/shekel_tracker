if ENV['RACK_ENV'] != 'production'
  require 'rake/clean'
  require 'roodi_task'

  CLEAN.include 'log/**'

  task default: [:clean, :rubocop, :sandi_meter, :roodi, :reek, :spec, :'coverage:check_specs', :cucumber, :shekel_tracker_ok]
end
