desc 'Run Sandi Meter against the code'

task :sandi_meter do
  puts 'Running Sandi_meter...'
  system('sandi_meter -d') || fail
end
