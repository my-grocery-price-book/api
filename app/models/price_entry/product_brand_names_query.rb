require 'singleton'
require './config/enviroment'

module PriceEntry
  # gets all the uniq brand names
  class ProductBrandNamesQuery
    def initialize(search_text:)
      @products = DB[:product_brand_names].limit(20)
      @products = @products.filter(Sequel.ilike(:product_brand_name, "%#{search_text}%"))
    end

    def execute
      @products.map(:product_brand_name)
    end
  end
end
