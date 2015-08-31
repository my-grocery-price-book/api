require 'singleton'
require './config/enviroment'

module PriceEntries
  # gets all the uniq unit names
  class UnitNamesQuery
    def initialize(region:)
      @unit_names = DB[:price_entries].filter(region: region).distinct.select(:package_unit)
    end

    def execute
      @unit_names.map(:package_unit)
    end
  end
end
