# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../config/enviroment')
require 'grape'
require 'grape-swagger'

require './app/commands/price_entry'

# main grape class
class PriceBookApi < Grape::API
  default_format :json

  rescue_from :all do |e|
    LOGGER.error(e)
    Rollbar.error(e)
    error_response(message: e.message)
  end

  desc 'Test Airbrake'
  get '/test_failure' do
    fail 'Test Failure'
  end

  desc 'ping'
  get '/ping' do
    'pong'
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
  params do
    optional :term, type: String, desc: 'search string'
  end
  get '/product_brand_names' do
    PriceEntry::ProductBrandNamesQuery.new(search_text: params.term).execute
  end

  desc 'get all the unit names'
  get '/unit_names' do
    PriceEntry::UnitNamesQuery.new.execute
  end

  desc 'get all the product names'
  get '/product_generic_names' do
    PriceEntry::ProductGenericNamesQuery.new.execute
  end

  resource :products do
    desc 'get list of price book entries'
    params do
      optional :term, type: String, desc: 'search string'
    end
    get do
      PriceEntry::ProductsQuery.new(term: params.term).execute
    end
  end

  resource :entries do
    desc 'Create a new price book entry'
    params do
      requires :product_brand_name, type: String, desc: 'Product brand specific name'
      optional :generic_name, type: String, desc: 'Generic Name'
      requires :category, type: String, desc: 'Category'
      requires :date_on, type: Date, desc: 'date of the price entry'
      requires :store, type: String, desc: 'Name of the store'
      requires :location, type: String, desc: 'location of the store'
      requires :package_size, type: Integer, desc: 'how much of each package_unit'
      requires :package_unit, type: String, desc: 'what is the packaging measured in'
      requires :quantity, type: Integer, desc: 'how many of each package'
      requires :total_price, type: Float, desc: 'price'
      optional :expires_on, type: Date, desc: 'when this price expires'
      optional :extra_info, type: String, desc: 'Additional information'
    end
    post do
      PriceEntry::AddPriceCommand.new(
        generic_name: params.generic_name, product_brand_name: params.product_brand_name,
        date_on: params.date_on, store: params['store'], location: params.location,
        package_size: params.package_size, package_unit: params.package_unit, quantity: params.quantity,
        total_price: params.total_price, category: params.category, expires_on: params.expires_on,
        extra_info: params.extra_info).execute
      { success: true }
    end

    desc 'get list of price book entries'
    params do
      optional :limit, type: String, desc: 'limit'
      optional :search, type: String, desc: 'search string'
    end
    get  do
      PriceEntry::PricesQuery.new(limit: params.limit, search_string: params.search).execute
    end
  end

  add_swagger_documentation hide_format: true
end
