# encoding: utf-8
require 'rubygems'
require 'bundler/setup'

require 'syslogger'
LOGGER = Syslogger.new('grocery_api', Syslog::LOG_PID, Syslog::LOG_LOCAL0)

require 'sequel'
DB = ENV['MUTANT'] ? Sequel.sqlite : Sequel.connect("sqlite://db/sqlite3/#{ENV['RACK_ENV']}_data.db")

Sequel.extension :migration
Sequel::Migrator.run(DB, './db/migrations')

DB.loggers << LOGGER
