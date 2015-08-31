require 'active_support/core_ext/hash/except'
require 'active_support/core_ext/date/calculations'
require './config/enviroment'
require_relative 'products_query/product_page'

module PriceEntries
  # get all the products and prices
  class ProductsQuery
    def initialize(region:, term:)
      @prices = DB[:price_entries]
                .where(region: region) { date_on > Date.today - 365 }
                .order(:price_per_package_unit)
                .where(Sequel.ilike(:product_brand_name, "%#{term}%"))
    end

    def execute
      product_names_and_units = @prices.select(:product_brand_name, :package_unit)
                                .all.uniq.first(10)

      products = product_names_and_units.collect do |product_name_and_unit|
        product_prices = @prices.where(product_name_and_unit)
        ProductPage.new(product_name_and_unit.merge(product_prices: product_prices))
      end

      products.map(&:to_hash)
    end
  end
end
