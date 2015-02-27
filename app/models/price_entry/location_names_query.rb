require 'singleton'
require './config/enviroment'

module PriceEntry
  # gets all the uniq location names
  class LocationNamesQuery
    def execute
      DB[:location_names].map(:location)
    end
  end
end

DB.create_view(:location_names, DB[:price_entries].distinct.select(:location), temp: true)
