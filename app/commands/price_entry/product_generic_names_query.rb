require 'singleton'
require './config/enviroment'

module PriceEntry
  # gets all the uniq product names
  class ProductGenericNamesQuery
    def execute
      DB[:product_generic_names].map(:generic_name)
    end
  end
end
