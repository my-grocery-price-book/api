# encoding: utf-8
begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  require 'rspec/core'
  require 'rspec/core/rake_task'
  desc 'Run our Spec'
  RSpec::Core::RakeTask.new(:spec)

  require 'mutant'
  desc 'Run mutation tests on the full PriceEntry namespace'
  task :mutant do
    result = Mutant::CLI.run(%w(-r ./app/models/price_entry --use rspec PriceEntry*))
    fail unless result == Mutant::CLI::EXIT_SUCCESS
  end

  task default: ['rubocop', :spec, :mutant]
rescue LoadError => e
  warn e.message
end
