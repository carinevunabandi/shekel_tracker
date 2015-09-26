desc 'Run reek against the code'

task :reek do
  puts 'Running reek...'
  system('reek') || fail
end
