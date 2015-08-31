require 'singleton'
require './config/enviroment'

module PriceEntries
  # get all the prices
  class PricesQuery
    def initialize(region:, limit:, search_string:)
      @region = region
      @limit = limit.to_i
      @limit = 10 if @limit.equal?(0)
      @search_string = search_string
    end

    def execute
      DB[:price_entries]
        .limit(@limit)
        .filter(region: @region)
        .filter(Sequel.like(:product_brand_name, "%#{@search_string}%"))
        .to_a
    end
  end
end
