# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../config/enviroment')

# main grape class
require 'grape'
class PriceBookApi < Grape::API
  version 'v1'
  format :json

  rescue_from :all do |e|
    LOGGER.error e
    Airbrake.notify(e)
    error_response(message: e.message)
  end

  get '/' do
    'Hello World'
  end
end
