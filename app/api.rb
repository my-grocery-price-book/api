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
    puts e.message
    puts e.backtrace.join("\n")
    error_response(message: e.message)
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
    end

    desc 'get list of price book entries'
    get do
      price_repo.all_as_array_hash
    end
  end

  add_swagger_documentation
end
