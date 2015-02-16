require 'singleton'
require 'daybreak'

require './app/models/price_entry/item'

module PriceEntry
  # class the is used to store and retrieve price items
  class Repo
    include Singleton

    def initialize
      @storage = Daybreak::DB.new("./db/price_entry_#{ENV['RACK_ENV']}.db")
      at_exit {
        @storage.close
      }
    end

    def store_names
      @storage.map{|_id, item| item.prices.map{|p| p[:store] } }.flatten.uniq
    end

    def location_names
      @storage.map{|_id, item| item.prices.map{|p| p[:location] } }.flatten.uniq
    end

    def brand_names
      @storage.map{|_id, item| item.prices.map{|p| p[:brand] } }.flatten.uniq
    end

    def unit_names
      @storage.map{|_id, item| item.unit }.uniq
    end

    def product_names
      @storage.map{|_id, item| item.name }.uniq
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

    def all
      @storage.first(5).map do |_id, item|
        item
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
