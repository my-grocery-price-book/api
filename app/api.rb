# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../config/enviroment')
require 'grape'
require 'grape-swagger'

require './app/models/price_entry'

# main grape class
class PriceBookApi < Grape::API
  default_format :json

  rescue_from :all do |e|
    LOGGER.error(e)
    error_response(message: e.message)
  end

  desc 'Test Airbrake'
  get '/test_failure' do
    fail 'Test Failure'
  end

  desc 'get all the stores'
  get '/store_names' do
    PriceEntry::StoreNamesQuery.new.execute
  end

  desc 'get all the location names'
  get '/location_names' do
    PriceEntry::LocationNamesQuery.new.execute
  end

  desc 'get all the brand names'
  get '/brand_names' do
    PriceEntry::BrandNamesQuery.new.execute
  end

  desc 'get all the unit names'
  get '/unit_names' do
    PriceEntry::UnitNamesQuery.new.execute
  end

  desc 'get all the product names'
  get '/product_names' do
    PriceEntry::ProductNamesQuery.new.execute
  end

  resource :entries do
    desc 'Create a new price book entry'
    params do
      requires :generic_name, type: String, desc: 'Generic Name'
      optional :date_on, type: Date, desc: 'date of the price entry'
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
      PriceEntry::AddPriceCommand.new(name: params.generic_name,
                                      date_on: params.date_on,
                                      store: params['store'],
                                      location: params.location,
                                      brand: params.brand,
                                      quanity: params.quanity,
                                      quanity_unit: params.quanity_unit,
                                      total_price: params.total_price,
                                      expires_on: params.expires_on,
                                      extra_info: params.extra_info).execute
      true
    end

    desc 'get list of price book entries'
    get do
      PriceEntry::ProductsQuery.new.execute
    end
  end

  add_swagger_documentation
end
