# encoding: utf-8
require 'rubocop/rake_task'
RuboCop::RakeTask.new

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
end

task default: ['rubocop:auto_correct', :test]
