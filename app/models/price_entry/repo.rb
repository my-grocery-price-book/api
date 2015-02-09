require 'singleton'

require './app/models/price_entry/item'

module PriceEntry
  # class the is used to store and retrieve price items
  class Repo
    include Singleton

    def initialize
      @all_objects = Hash.new do |hash, key|
        hash[key] = PriceEntry::Item.new(name: key.first, unit: key.last)
      end
    end

    def find_or_create_by_name_and_unit(name:, unit:)
      @all_objects[[name, unit]]
    end

    def save(item)
      @all_objects[[item.name, item.unit]] = item
    end

    def all_as_array_hash
      @all_objects.map do |_key, item|
        {
          generic_name: item.name,
          quanity_unit: item.unit,
          prices: item.prices
        }
      end
    end

    def reset
      @all_objects.clear
    end
  end
end
