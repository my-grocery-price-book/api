require 'singleton'
require 'couchrest'

require './app/models/price_entry/item'

module PriceEntry
  # class the is used to store and retrieve price items
  class Repo
    include Singleton

    attr_reader :db

    def initialize
      @db = CouchRest.database!("http://127.0.0.1:5984/price_api_#{ENV['RACK_ENV']}")
    end

    def create(price_entry_object)
      result = db.save_doc(price_entry_to_hash(price_entry_object))
      result['id']
    end

    def find_by_id(id)
      doc = db.get(id)
      key_doc = doc.to_hash.inject({}) { |memo, (k, v)| memo[k.to_sym] = v; memo }
      PriceEntry::Item.new(key_doc)
    end

    def price_entry_to_hash(p)
      {
        generic_name: p.generic_name,
        date_on: p.date_on,
        store: p.store,
        location: p.location,
        brand: p.brand,
        quanity: p.quanity,
        quanity_unit: p.quanity_unit,
        total_price: p.total_price,
        expires_on: p.expires_on,
        extra_info: p.extra_info
      }
    end

    def all_as_hash
      db.all_docs['rows'].map do |row|
        db.get(row['id'])
      end
    end

    def reset
      db.recreate!
    end
  end
end
