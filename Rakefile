require "bundler/gem_tasks"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new

require 'cucumber'
require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

task :default => :test
task :test => [:spec, :features]
