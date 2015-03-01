# encoding: utf-8
require 'rubygems'
require 'bundler/setup'
require 'logger'

LOGGER = Logger.new('log/test.log')

require 'sequel'
DB = ENV['MUTANT'] ? Sequel.sqlite : Sequel.connect("sqlite://db/sqlite3/#{ENV['RACK_ENV']}_data.db")

Sequel.extension :migration
Sequel::Migrator.run(DB, './db/migrations')

DB.loggers << LOGGER
