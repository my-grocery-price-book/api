require 'singleton'
require './config/enviroment'

module PriceEntry
  # gets all the uniq unit names
  class UnitNamesQuery
    def execute
      DB[:unit_names].map(:package_unit)
    end
  end
end
