require 'rubygems'
require 'bundler/setup'
require 'simplecov'
require 'rspec'
ENV['RACK_ENV'] = 'test'

require './config/enviroment'

require 'logger'
LOGGER = Logger.new('log/test.log')
