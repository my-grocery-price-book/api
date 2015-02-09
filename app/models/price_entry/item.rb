module PriceEntry
  # Single model representing a price of a item at a specific time and store
  class Item
    attr_reader :name, :unit

    def prices
      @prices.clone.freeze
    end

    def initialize(name:, unit:)
      @name = name
      @unit = unit
      @prices = []
    end

    def add_price(date_on:, store:, location:, brand:, quanity:,
                   total_price:, expires_on: nil, extra_info: nil)
      @prices.push(
        date_on: date_on,
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
