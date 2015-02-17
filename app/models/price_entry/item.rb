require 'date'

module PriceEntry
  # Single model representing a price of a item at a specific time and store
  class Item
    attr_reader :name, :unit

    def prices
      @prices.to_a
    end

    def initialize(name:, unit:, prices: [])
      @name = name
      @unit = unit
      @prices = Set.new
      prices.each do |price|
        add_price(price)
      end
    end

    def add_price(store:, location:, brand:, quanity:,
                   total_price:, date_on: nil, expires_on: nil, extra_info: nil)
      @prices.add(
        date_on: date_on || Date.today,
        store: store,
        location: location,
        brand: brand,
        quanity: quanity,
        total_price: total_price,
        expires_on: expires_on,
        extra_info: extra_info
      )
    end
  end
end
