require 'singleton'
require './config/enviroment'

module PriceEntries
  # get all the prices
  class PricesQuery
    def initialize(region:, limit:, search_string:, product_brand_names:, package_unit:)
      @region = region
      @limit = [limit.to_i,100].min
      @limit = 10 if @limit.equal?(0)
      @search_string = search_string
      @product_brand_names = product_brand_names
      @package_unit = package_unit
    end

    def execute
      filtered_prices = DB[:price_entries]
                        .limit(@limit)
                        .filter(region: @region)
                        .filter(Sequel.like(:product_brand_name, "%#{@search_string}%"))
      if @product_brand_names
        filtered_prices = filtered_prices.filter(product_brand_name: @product_brand_names)
      end
      if @package_unit
        filtered_prices = filtered_prices.filter(package_unit: @package_unit)
      end
      filtered_prices.to_a
    end
  end
end
