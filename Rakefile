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

namespace :db do
  desc 'create database'
  task :create do
    require 'dotenv'
    ENV['RACK_ENV'] ||= 'development'
    Dotenv.load(".env.#{ENV['RACK_ENV']}", '.env')
    command = 'createdb'
    command << " --host=#{ENV['RDS_HOSTNAME']}" if ENV['RDS_HOSTNAME']
    command << " --port=#{ENV['RDS_PORT']}" if ENV['RDS_PORT']
    command << " -username=#{ENV['RDS_USERNAME']}" if ENV['RDS_USERNAME']
    command << ' -W' if ENV['RDS_PASSWORD']
    command << " #{ENV['RDS_DB_NAME']}"
    puts command
    `#{command}`
  end
end
