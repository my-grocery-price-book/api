module PriceEntries
  # get all the products and prices
  class ProductsQuery
    # used to help build the ProductQuery response
    class ProductPage
      def initialize(product_brand_name:, package_unit:, product_prices:)
        @product_brand_name = product_brand_name
        @package_unit = package_unit
        @product_prices = product_prices
      end

      def to_hash
        {
          product: @product_brand_name,
          package_unit: @package_unit,
          cheapest_last_week: best_price_last_week,
          cheapest_last_month: best_price_last_month,
          cheapest_last_year: best_price_last_year
        }
      end

      private

      def best_price_last_year
        best_price_last_year = @product_prices.first
        best_price_last_year.except!(:id)
      end

      def best_price_last_month
        best_price_last_month = @product_prices.where { date_on > Date.today - 30 }.first
        best_price_last_month.except!(:id) if best_price_last_month
      end

      def best_price_last_week
        best_price_last_week = @product_prices.where { date_on > Date.today - 7 }.first
        best_price_last_week.except!(:id) if best_price_last_week
      end
    end
  end
end
