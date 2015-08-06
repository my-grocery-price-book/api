require 'singleton'
require './config/enviroment'

module PriceEntry
  # gets all the uniq product names
  class ProductGenericNamesQuery
    def initialize(region:)
      @product_generic_names = DB[:price_entries].filter(region: region)
                               .distinct.select(:generic_name)
    end

    def execute
      @product_generic_names.map(:generic_name)
    end
  end
end
