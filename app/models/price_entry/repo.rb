require 'singleton'
require 'daybreak'

require './app/models/price_entry/item'

module PriceEntry
  # class the is used to store and retrieve price items
  class Repo
    include Singleton

    def initialize
      @storage = Daybreak::DB.new("./db/price_entry_#{ENV['RACK_ENV']}.db")
    end

    def find_or_create_by_name_and_unit(name, unit)
      price_item = find_by_name_and_unit(name, unit)
      return price_item if price_item
      item = PriceEntry::Item.new(name: name, unit: unit)
      save(item)
      item
    end

    def save(item)
      @storage.synchronize do
        @storage["#{item.name}_#{item.unit}"] = item
      end
    end

    def all_as_array_hash
      @storage.map do |_id, item|
        {
          generic_name: item.name,
          quanity_unit: item.unit,
          prices: item.prices
        }
      end
    end

    def reset
      @storage.clear
    end

    private

    def find_by_name_and_unit(name, unit)
      @storage["#{name}_#{unit}"]
    end

    def item_to_hash(item)
      {
        generic_name: item.generic_name,
        quanity_unit: item.quanity_unit,
        prices: item.prices
      }
    end
  end
end
