module PriceEntry
  class Item
    attr_reader :generic_name, :date_on, :store, :location, :brand, :quanity,
                :quanity_unit, :total_price, :expires_on, :extra_info

    def initialize(generic_name:, date_on:, store:, location:, brand:, quanity:,
                   quanity_unit:, total_price:, expires_on:, extra_info:)
      @generic_name = generic_name
      @date_on = date_on
      @store = store
      @location = location
      @brand = brand
      @quanity = quanity
      @quanity_unit = quanity_unit
      @total_price = total_price
      @expires_on = expires_on
      @extra_info = extra_info
    end

    def to_hash
      {
        generic_name: generic_name,
        date_on: date_on,
        store: store,
        location: location,
        brand: brand,
        quanity: quanity,
        quanity_unit: quanity_unit,
        total_price: total_price,
        expires_on: expires_on,
        extra_info: extra_info
      }
    end
  end
end
