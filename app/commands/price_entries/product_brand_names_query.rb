require 'singleton'
require './config/enviroment'

module PriceEntries
  # gets all the uniq brand names
  class ProductBrandNamesQuery
    def initialize(region:, search_text:)
      @products = DB[:price_entries].filter(region: region)
                  .distinct.select(:product_brand_name).limit(20)
                  .filter(Sequel.ilike(:product_brand_name, "%#{search_text}%"))
    end

    def execute
      @products.map(:product_brand_name)
    end
  end
end
