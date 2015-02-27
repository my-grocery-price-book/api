require 'singleton'
require './config/enviroment'

module PriceEntry
  # returns uniq storage names
  class StoreNamesQuery
    def execute
      DB[:store_names].map(:store)
    end
  end
end

DB.create_view(:store_names, DB[:price_entries].distinct.select(:store), temp: true)
