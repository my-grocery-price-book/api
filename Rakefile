# encoding: utf-8
begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError => e
  warn e.message
end

begin
  require 'rspec/core'
  require 'rspec/core/rake_task'

  desc 'Run our Spec'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError => e
  warn e.message
end

task default: ['rubocop', :spec]
