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
