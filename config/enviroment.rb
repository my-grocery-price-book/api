# encoding: utf-8
require 'rubygems'
require 'bundler/setup'

require 'airbrake'

Airbrake.configure do |config|
  #  config.api_key = 'df05cf32058ebb4dc9a2113f6396c8c5'
  config.host    = 'ubxd-mxit-apps-errbit.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
  ## can also set the environment over here
  config.environment_name = ENV['RACK_ENV']
end

require 'elasticsearch'
client = Elasticsearch::Client.new
index =  (ENV['RACK_ENV'] || 'development')
unless client.indices.exists index: index
  client.indices.create index: index
end
