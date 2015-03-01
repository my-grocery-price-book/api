require 'singleton'
require './config/enviroment'

module PriceEntry
  # gets all the uniq brand names
  class BrandNamesQuery
    def execute
      DB[:brand_names].map(:brand)
    end
  end
end
