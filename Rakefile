require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc 'Run style checker'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
end

desc 'Run all tests.'
task :ci do
  Rake::Task[:rubocop].invoke
  Rake::Task[:spec].invoke
end

task default: :ci
