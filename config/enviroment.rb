# encoding: utf-8
require 'rubygems'
require 'bundler/setup'

require 'rollbar'
Rollbar.configure do |config|
  config.access_token = 'b330dae833714676a4e8c809b11144f6'
  config.disable_monkey_patch = true
  config.environment = ENV['RACK_ENV'] || 'development'
end

require 'syslogger'
LOGGER = Syslogger.new('grocery_api', Syslog::LOG_PID, Syslog::LOG_LOCAL0)

require 'sequel'
DB = ENV['MUTANT'] ? Sequel.sqlite : Sequel.connect("sqlite://db/sqlite3/#{ENV['RACK_ENV']}_data.db")

Sequel.extension :migration
Sequel::Migrator.run(DB, './db/migrations')

DB.loggers << LOGGER
