require 'singleton'
require './config/enviroment'

module PriceEntry
  # gets all the uniq product names
  class ProductNamesQuery
    def execute
      DB[:product_names].map(:name)
    end
  end
end
