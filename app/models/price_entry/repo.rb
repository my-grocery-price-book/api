require 'singleton'
require 'daybreak'

require './app/models/price_entry/item'

module PriceEntry
  # class that is used to store and retrieve price items
  class Repo
    include Singleton
    attr_writer :storage

    def store_names
      all.map { |item| item.prices.map { |p| p[:store] } }.flatten.uniq
    end

    def location_names
      all.map { |item| item.prices.map { |p| p[:location] } }.flatten.uniq
    end

    def brand_names
      all.map { |item| item.prices.map { |p| p[:brand] } }.flatten.uniq
    end

    def unit_names
      all.map(&:unit).uniq
    end

    def product_names
      all.map(&:name).uniq
    end

    def find_or_create_by_name_and_unit(name, unit)
      price_item = find_by_name_and_unit(name, unit)
      return price_item if price_item
      item = PriceEntry::Item.new(name: name, unit: unit)
      save(item)
      item
    end

    def save(item)
      @storage.use_db do |storage|
        storage["#{item.name}_#{item.unit}"] = item
      end
    end

    def all
      results = []
      @storage.use_db do |storage|
        storage.map do |_id, item|
          results << item
        end
      end
      results
    end

    def reset
      @storage.use_db(&:clear)
    end

    private

    def find_by_name_and_unit(name, unit)
      @storage.use_db do |storage|
        storage["#{name}_#{unit}"]
      end
    end
  end
end

class Storage
  def initialize(db)
    @db = db
  end

  def map(&block)
    @db.map(&block)
  end

  def clear
    @db.clear
  end

  def [](v)
    @db[v]
  end

  def []=(v,item)
    old_item = @db[v]
    if old_item
      old_item.prices.each do |price|
        item.add_price(price)
      end
    end
    @db[v] = item
  end

  def self.use_db
    db = Daybreak::DB.new("./db/price_entry_#{ENV['RACK_ENV']}.db")
    db.lock do
      yield new(db)
    end
  ensure
    db.close
  end
end

PriceEntry::Repo.instance.storage = Storage
