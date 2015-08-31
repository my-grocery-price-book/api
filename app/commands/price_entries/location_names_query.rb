require 'singleton'
require './config/enviroment'

module PriceEntries
  # gets all the uniq location names
  class LocationNamesQuery
    def initialize(region:)
      @region = region
    end

    def execute
      DB[:price_entries].filter(region: @region)
        .distinct.select(:location).map(:location)
    end
  end
end
