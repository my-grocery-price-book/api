require 'singleton'
require './config/enviroment'

module PriceEntry
  # get all the products and prices
  class ProductsQuery
    def initialize(limit: 10)
      @limit = limit
    end

    def execute
      DB[:products].limit(@limit).map do |product|
        filtered_prices = DB[:price_entries].filter(generic_name: product[:generic_name],
                                                    quanity_unit: product[:quanity_unit])
        prices = filtered_prices.limit(3).map { |p| p.tap { |d| d.delete(:id) } }
        { generic_name: product[:generic_name],
          quanity_unit: product[:quanity_unit],
          prices: prices }
      end
    end
  end
end
