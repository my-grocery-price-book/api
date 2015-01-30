# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../config/enviroment')
require 'grape'

# main grape class
class PriceBookApi < Grape::API
  version 'v1'
  content_type :xml, 'application/xml'
  content_type :json, 'application/json'
  content_type :txt, 'text/plain'

  default_format :json

  rescue_from :all do |e|
    LOGGER.error e
    Airbrake.notify(e)
    error_response(message: e.message)
  end

  resource :entries do
    desc 'Create a new price book entry'
    # params do
    #   requires :status, type: String, desc: "Your status."
    # end
    post do
      true
    end
  end
end
