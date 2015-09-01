require 'singleton'
require './config/enviroment'

module PriceEntries
  # get all the prices
  class PricesQuery
    def initialize(region:, limit:, search_string:, product_brand_names:)
      @region = region
      @limit = limit.to_i
      @limit = 10 if @limit.equal?(0)
      @search_string = search_string
      @product_brand_names = product_brand_names
    end

    def execute
      filtered_prices = DB[:price_entries]
                          .limit(@limit)
                          .filter(region: @region)
                          .filter(Sequel.like(:product_brand_name, "%#{@search_string}%"))
      if @product_brand_names
        filtered_prices = filtered_prices.filter(product_brand_name: @product_brand_names)
      end
      filtered_prices.to_a
    end
  end
end
