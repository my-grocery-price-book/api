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

  desc 'get all the product brand names'
  get '/product_brand_names' do
    PriceEntry::ProductBrandNamesQuery.new.execute
  end

  desc 'get all the unit names'
  get '/unit_names' do
    PriceEntry::UnitNamesQuery.new.execute
  end

  desc 'get all the product names'
  get '/product_generic_names' do
    PriceEntry::ProductGenericNamesQuery.new.execute
  end

  resource :entries do
    desc 'Create a new price book entry'
    params do
      requires :generic_name, type: String, desc: 'Generic Name'
      requires :product_brand_name, type: String, desc: 'Product brand specific name'
      optional :date_on, type: Date, desc: 'date of the price entry'
      requires :store, type: String, desc: 'Name of the store'
      requires :location, type: String, desc: 'location of the store'
      requires :package_type, type: String, desc: 'packaging'
      requires :package_size, type: Integer, desc: 'how much in each package_type'
      requires :package_unit, type: String, desc: 'what is the packaging measured in'
      optional :package_serves, type: Integer, desc: 'how many each package_type can serve'
      requires :quanity, type: Float, desc: 'how many package_types'
      requires :total_price, type: Float, desc: 'price'
      optional :expires_on, type: Date, desc: 'when this price expires'
      optional :extra_info, type: String, desc: 'Additional information'
    end
    post do
      PriceEntry::AddPriceCommand.new(
        generic_name: params.generic_name, product_brand_name: params.product_brand_name,
        date_on: params.date_on, store: params['store'], location: params.location,
        package_type: params.package_type, package_size: params.package_size,
        package_unit: params.package_unit, package_serves: params.package_serves,
        quanity: params.quanity, total_price: params.total_price,
        expires_on: params.expires_on, extra_info: params.extra_info).execute
      true
    end

    desc 'get list of price book entries'
    params do
      optional :limit, type: String, desc: 'limit'
      optional :search, type: String, desc: 'search string'
    end
    get do
      PriceEntry::ProductsQuery.new(limit: params.limit, search_string: params.search).execute
    end
  end

  add_swagger_documentation
end
