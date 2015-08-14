# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../config/enviroment')
require 'grape'

require './app/commands/price_entry'
require './app/commands/user'

# main grape class
class PriceBookApi < Grape::API
  default_format :json

  rescue_from :all do |e|
    if e.is_a?(Grape::Exceptions::ValidationErrors) || e.is_a?(User::ValidationError)
      LOGGER.warn(e)
      error!(e.message, 400)
    else
      LOGGER.error(e)
      Rollbar.error(e)
      error!(e.message)
    end
  end

  desc 'Test Airbrake'
  get '/test_failure' do
    fail 'Test Failure'
  end

  desc 'ping'
  get '/ping' do
    'pong'
  end

  desc 'creating new user'
  params do
    requires :email, type: String, desc: 'Email address'
    optional :shopper_name, type: String, desc: 'Shopper display Name'
  end
  post '/users' do
    User::AddCommand.new(email: params.email, shopper_name: params.shopper_name).execute
  end

  namespace ':region' do
    desc 'get all the stores'
    get '/store_names' do
      PriceEntry::StoreNamesQuery.new(region: params.region).execute
    end

    desc 'get all the location names'
    get '/location_names' do
      PriceEntry::LocationNamesQuery.new(region: params.region).execute
    end

    desc 'get all the product brand names'
    params do
      optional :term, type: String, desc: 'search string'
    end
    get '/product_brand_names' do
      PriceEntry::ProductBrandNamesQuery.new(region: params.region, search_text: params.term).execute
    end

    desc 'get all the unit names'
    get '/unit_names' do
      PriceEntry::UnitNamesQuery.new(region: params.region).execute
    end

    desc 'get all the product names'
    get '/product_generic_names' do
      PriceEntry::ProductGenericNamesQuery.new(region: params.region).execute
    end

    resource :products do
      desc 'get list of price book entries'
      params do
        optional :term, type: String, desc: 'search string'
      end
      get do
        PriceEntry::ProductsQuery.new(region: params.region, term: params.term).execute
      end
    end

    resource :entries do
      desc 'Create a new price book entry'
      params do
        requires :api_key, type: String, desc: 'Shopper API key'
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
        shopper_id = User::GetShopperIdForKey.new(api_key: params.api_key).execute
        error!('invalid api_key', 401) if shopper_id.nil?
        PriceEntry::AddPriceCommand.new(
          generic_name: params.generic_name, product_brand_name: params.product_brand_name,
          date_on: params.date_on, store: params['store'], location: params.location, region: params.region,
          package_size: params.package_size, package_unit: params.package_unit, quantity: params.quantity,
          total_price: params.total_price, category: params.category, expires_on: params.expires_on,
          extra_info: params.extra_info, shopper_id: shopper_id).execute
        { success: true }
      end

      desc 'get list of price book entries'
      params do
        optional :limit, type: String, desc: 'limit'
        optional :search, type: String, desc: 'search string'
      end
      get do
        PriceEntry::PricesQuery.new(region: params.region,
                                    limit: params.limit,
                                    search_string: params.search).execute
      end
    end
  end
end
