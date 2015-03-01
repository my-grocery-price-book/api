require 'rubygems'
require 'bundler/setup'
require 'simplecov'

require './config/enviroment'

require 'logger'

DB.loggers << Logger.new('log/test.log')

require 'rspec'
ENV['RACK_ENV'] = 'test'
