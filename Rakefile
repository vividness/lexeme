require 'rspec/core/rake_task'
 
desc 'Default: run specs.'
task :default => :spec
 
desc "Generate code coverage"
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end
