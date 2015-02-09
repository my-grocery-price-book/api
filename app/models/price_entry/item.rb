module PriceEntry
  # Single model representing a price of a item at a specific time and store
  class Item
    attr_reader :generic_name, :date_on, :store, :location, :brand, :quanity,
                :quanity_unit, :total_price, :expires_on, :extra_info, :id, :rev

    def initialize(generic_name:, date_on:, store:, location:, brand:, quanity:,
                   quanity_unit:, total_price:, expires_on: nil, extra_info: nil,
                   _id: nil, _rev: nil)
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
      @id = _id
      @rev = _rev
    end
  end
end
