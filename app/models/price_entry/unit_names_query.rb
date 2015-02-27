require 'singleton'
require './config/enviroment'

module PriceEntry
  # gets all the uniq unit names
  class UnitNamesQuery
    def execute
      DB[:unit_names].map(:quanity_unit)
    end
  end
end

DB.create_view(:unit_names, DB[:price_entries].distinct.select(:quanity_unit), temp: true)
