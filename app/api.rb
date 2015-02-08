# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../config/enviroment')
require 'grape'
require 'grape-swagger'

require './app/models/price_entry/repo'
require './app/models/price_entry/item'

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
      item = PriceEntry::Item.new(generic_name: params.generic_name,
                                  date_on: params.date_on,
                                  store: params['store'],
                                  location: params.location,
                                  brand: params.brand,
                                  quanity: params.quanity,
                                  quanity_unit: params.quanity_unit,
                                  total_price: params.total_price,
                                  expires_on: params.expires_on,
                                  extra_info: params.extra_info)
      PriceEntry::Repo.instance.create(item)
    end

    desc 'get list of price book entries'
    get do
      PriceEntry::Repo.instance.all_as_hash
    end
  end

  add_swagger_documentation
end
