require 'singleton'
require './config/enviroment'

module PriceEntry
  # get all the prices
  class PricesQuery
    def initialize(limit: nil, search_string: nil)
      @limit = (limit.nil? || limit.eql?('')) ?  10 : limit
      @search_string = search_string
    end

    def execute
      DB[:price_entries].limit(@limit).filter(Sequel.like(:product_brand_name, "%#{@search_string}%")).to_a
    end
  end
end
