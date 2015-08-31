require 'singleton'
require './config/enviroment'

module PriceEntries
  # returns uniq storage names
  class StoreNamesQuery
    def initialize(region:)
      @store_names = DB[:price_entries].filter(region: region).distinct.select(:store)
    end

    def execute
      @store_names.order(:store).map(:store)
    end
  end
end
