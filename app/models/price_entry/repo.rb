require 'singleton'
require 'rom'

require './app/models/price_entry/item'

module PriceEntry
  # class the is used to store and retrieve price items
  class Repo
    include Singleton

    def initialize
      rom_setup = ROM.setup(:memory)

      rom_setup.relation(:price_entry_items) do
        def by_name_and_unit(name, unit)
          restrict(name: name, unit: unit)
        end
      end

      rom_setup.mappers do
        define(:price_entry_items) do
          model Item
          attribute :name, type: :string
          attribute :unit, type: :string
          attribute :prices, type: :array,
                    header: [[:date_on], [:store], [:location], [:brand], [:quanity],
                             [:total_price], [:expires_on], [:extra_info]]
        end
      end

      rom_setup.commands(:price_entry_items) do
        define(:create)
        define(:update)
        define(:delete)
      end

      @rom = rom_setup.finalize
    end

    def find_or_create_by_name_and_unit(name, unit)
      price_object = rom.read(:price_entry_items).by_name_and_unit(name,unit).first
      return price_object if price_object
      item = PriceEntry::Item.new(name: name,unit: unit)
      rom.command(:price_entry_items).create(item)
      item
    end

    def save(item)
      price_object = rom.read(:price_entry_items).by_name_and_unit(item.name,item.unit).first
      if price_object
        rom.command(:price_entry_items).update(item)
      else
        rom.command(:price_entry_items).create(item)
      end
    end

    def all_as_array_hash
      rom.read(:price_entry_items).map do |item|
        {
          generic_name: item.name,
          quanity_unit: item.unit,
          prices: item.prices
        }
      end
    end

    def reset
      rom.command(:price_entry_items).delete
    end

    private

    def rom
      @rom
    end
  end
end
