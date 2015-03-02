require 'singleton'
require './config/enviroment'

module PriceEntry
  # gets all the uniq brand names
  class ProductBrandNamesQuery
    def execute
      DB[:product_brand_names].map(:product_brand_name)
    end
  end
end
