require 'singleton'
require './config/enviroment'

module PriceEntry
  # adds a price entry into storage
  class AddPriceCommand
    def initialize(generic_name:, store:, location:, product_brand_name:, quanity:, quanity_unit:,
                  total_price:, sets_of: nil, date_on: nil, expires_on: nil, extra_info: nil)
      date_on = Date.today if date_on.nil? || date_on.eql?('')
      sets_of = 1 if sets_of.nil? || sets_of.eql?('')
      @params = { generic_name: generic_name, store: store, location: location, product_brand_name: product_brand_name,
                  quanity: quanity, quanity_unit: quanity_unit, total_price: total_price, date_on: date_on,
                  expires_on: expires_on, extra_info: extra_info, sets_of: sets_of }
    end

    def execute
      DB[:price_entries].insert(@params)
    end
  end
end
