require 'singleton'
require './config/enviroment'

module PriceEntry
  # get all the products and prices
  class ProductsQuery
    def initialize(limit: nil, search_string: nil)
      @limit = (limit.nil? || limit == '') ?  10 : limit
      @search_string = search_string
    end

    def execute
      products = DB[:products].limit(@limit)
      if @search_string
        products = products.filter(Sequel.like(:generic_name, "%#{@search_string}%"))
      end
      render_products(products)
    end

    private

    def render_products(products)
      products.map do |product|
        filtered_prices = DB[:price_entries].filter(generic_name: product[:generic_name],
                                                    package_unit: product[:package_unit])
        prices = filtered_prices.limit(3).map { |p| p.tap { |d| d.delete(:id) } }
        { generic_name: product[:generic_name],
          package_unit: product[:package_unit],
          prices: prices }
      end
    end
  end
end
