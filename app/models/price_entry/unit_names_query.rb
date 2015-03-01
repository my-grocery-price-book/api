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
