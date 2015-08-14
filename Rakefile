# encoding: utf-8
begin
  require 'rspec/core'
  require 'rspec/core/rake_task'
  desc 'Run our Spec'
  RSpec::Core::RakeTask.new(:spec)

  require 'mutant'
  desc 'Run mutation tests on the full PriceEntry namespace'
  task :mutant do
    ENV['MUTANT'] = 'yes'
    result = Mutant::CLI.run(%w(-r ./app/commands/user --use rspec User*))
    fail unless result == Mutant::CLI::EXIT_SUCCESS
    result = Mutant::CLI.run(%w(-r ./app/commands/price_entry --use rspec PriceEntry*))
    fail unless result == Mutant::CLI::EXIT_SUCCESS
  end

  task default: [:spec, :mutant]
rescue LoadError => e
  warn e.message
end
