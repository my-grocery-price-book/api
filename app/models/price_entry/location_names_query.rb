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
