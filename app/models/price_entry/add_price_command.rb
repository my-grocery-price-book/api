require 'singleton'
require './config/enviroment'

module PriceEntry
  # adds a price entry into storage
  class AddPriceCommand
    def initialize(generic_name:, store:, location:, product_brand_name:, quanity:, quanity_unit:,
                  total_price:, date_on: nil, expires_on: nil, extra_info: nil)
      date_on = Date.today if date_on.nil? || date_on.eql?('')
      @params = { generic_name: generic_name, store: store, location: location, product_brand_name: product_brand_name,
                  quanity: quanity, quanity_unit: quanity_unit, total_price: total_price, date_on: date_on,
                  expires_on: expires_on, extra_info: extra_info }
    end

    def execute
      DB[:price_entries].insert(@params)
    end
  end
end
