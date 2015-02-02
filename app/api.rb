# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../config/enviroment')
require 'grape'
require 'grape-swagger'
require 'elasticsearch'

# main grape class
class PriceBookApi < Grape::API
  default_format :json

  rescue_from :all do |e|
    Airbrake.notify(e)
    puts e.message
    puts e.backtrace.join("\n")
    error_response(message: e.message)
  end

  resource :entries do
    desc 'Create a new price book entry'
    params do
      requires :generic_name, type: String, desc: 'Generic Name'
      requires :date_on, type: Date, desc: 'date of the price entry'
      requires :store, type: String, desc: 'Name of the store'
      requires :location, type: String, desc: 'location of the store'
      requires :brand, type: String, desc: 'brand name'
      requires :quanity, type: Float, desc: 'quanity'
      requires :quanity_unit, type: String, desc: 'what is the quanity measured in'
      requires :total_price, type: Float, desc: 'price'
      optional :expires_on, type: Date, desc: 'quanity'
      optional :extra_info, type: String, desc: 'what is the quanity measured in'
    end
    post do
      client = Elasticsearch::Client.new
      index =  (ENV['RACK_ENV'] || 'development')
      client.index index: index, body: params, type: 'price_entry'
    end

    desc 'get list of price book entries'
    get do
      client = Elasticsearch::Client.new
      index =  (ENV['RACK_ENV'] || 'development')
      results = (client.search index: index)
      results['hits']['hits'].map do |hit|
        hit['_source']
      end
    end
  end

  add_swagger_documentation
end
