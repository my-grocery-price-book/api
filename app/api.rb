# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../config/enviroment')
require 'grape'
require 'grape-swagger'

require './app/models/price_entry/repo'
require './app/models/price_entry/item'

def price_repo
  PriceEntry::Repo.instance
end

# main grape class
class PriceBookApi < Grape::API
  default_format :json

  rescue_from :all do |e|
    Airbrake.notify(e)
    error_response(message: e.message)
  end

  desc 'Test Airbrake'
  get '/test_airbrake' do
    fail 'Test Airbrake'
  end

  desc 'get all the stores'
  get '/store_names' do
    price_repo.store_names
  end

  desc 'get all the location names'
  get '/location_names' do
    price_repo.location_names
  end

  desc 'get all the brand names'
  get '/brand_names' do
    price_repo.brand_names
  end

  desc 'get all the unit names'
  get '/unit_names' do
    price_repo.unit_names
  end

  desc 'get all the product names'
  get '/product_names' do
    price_repo.product_names
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
      item = price_repo.find_or_create_by_name_and_unit(
        params.generic_name, params.quanity_unit
      )
      item.add_price(date_on: params.date_on,
                     store: params['store'],
                     location: params.location,
                     brand: params.brand,
                     quanity: params.quanity,
                     total_price: params.total_price,
                     expires_on: params.expires_on,
                     extra_info: params.extra_info)
      price_repo.save(item)
      true
    end

    desc 'get list of price book entries'
    get do
      price_repo.all.map do |item|
        {
          generic_name: item.name,
          quanity_unit: item.unit,
          prices: item.prices
        }
      end
    end
  end

  add_swagger_documentation
end
