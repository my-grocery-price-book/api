require 'singleton'
require './config/enviroment'

module PriceEntry
  # adds a price entry into storage
  class AddPriceCommand
    def initialize(generic_name:, store:, location:, product_brand_name:, quanity:, package_type:,
                   package_size:, package_unit:, total_price:, date_on:, category:, package_serves: nil,
                   expires_on: nil, extra_info: nil)
      package_serves = 1 if package_serves.nil? || package_serves.eql?('')
      @params = { generic_name: generic_name, store: store, location: location, product_brand_name: product_brand_name,
                  quanity: quanity, package_type: package_type,  package_size: package_size, package_unit: package_unit,
                  package_serves: package_serves, total_price: total_price, date_on: date_on, expires_on: expires_on,
                  extra_info: extra_info, category: category }
    end

    def execute
      DB[:price_entries].insert(@params)
    end
  end
end
