require 'ostruct'
require './config/enviroment'

module PriceEntries
  # adds a price entry into storage
  class AddPriceCommand
    def initialize(price_entry_params:, price_entries:)
      @price_entries = price_entries
      @price_entry = new_price(price_entry_params)
      @params = { generic_name: @price_entry.generic_name, store: @price_entry.store, location: @price_entry.location,
                  product_brand_name: @price_entry.product_brand_name, quantity: @price_entry.quantity,
                  package_size: @price_entry.package_size, package_unit: @price_entry.package_unit,
                  region: @price_entry.region, total_price: @price_entry.total_price, date_on: @price_entry.date_on,
                  category: @price_entry.category, price_per_package_unit: @price_entry.price_per_package_unit }
    end

    def execute
      @price_entries.insert(@params)
    end

    private

    def new_price(params)
      params = OpenStruct.new(params)
      PriceEntry.new(generic_name: params.generic_name,
                     product_brand_name: params.product_brand_name,
                     date_on: params.date_on,
                     store: params.store,
                     location: params.location,
                     region: params.region,
                     package_size: params.package_size,
                     package_unit: params.package_unit,
                     quantity: params.quantity,
                     total_price: params.total_price,
                     category: params.category)
    end
  end
end
