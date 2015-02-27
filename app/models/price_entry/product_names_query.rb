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

DB.create_view(:product_names, DB[:price_entries].distinct.select(:name), temp: true)
