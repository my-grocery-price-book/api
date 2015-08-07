# encoding: utf-8
require 'rubygems'
require 'bundler/setup'
require 'dotenv'
ENV['RACK_ENV'] ||= 'development'
Dotenv.load(".env.#{ENV['RACK_ENV']}", '.env')

require 'rollbar'
Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
  config.disable_monkey_patch = true
  config.environment = ENV['RACK_ENV']
  config.enabled = (ENV['MUTANT'].nil? && ENV['RACK_ENV'] == 'production')
end

begin
  require 'logger'
  LOGGER = Logger.new("log/#{ENV['RACK_ENV']}.log")
  LOGGER.level = Logger::DEBUG
  LOGGER.info("Loading Api Enviroment for #{`whoami`}")

  require 'sequel'
  DB = ENV['MUTANT'] ? Sequel.sqlite : Sequel.connect(ENV['SEQUEL_CONNECT'])
  DB.loggers << LOGGER

  Sequel.extension :migration
  Sequel::Migrator.run(DB, './db/migrations')

  LOGGER.info("Api Enviroment Loaded and DB Migrated for #{`whoami`}")
rescue => e
  Rollbar.critical(e)
end
