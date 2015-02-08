require 'singleton'
require 'couchrest'

require './app/models/price_entry/item'

module PriceEntry
  class Repo
    include Singleton

    def create(price_entry_object)
      result = db.save_doc(price_entry_to_hash(price_entry_object))
      result['id']
    end

    def find_by_id(id)
      doc = db.get(id)
      PriceEntry::Item.new(generic_name: doc['generic_name'],
                           date_on: Date.parse(doc['date_on']),
                           store: doc['store'],
                           location: doc['location'],
                           brand: doc['brand'],
                           quanity: doc['quanity'],
                           quanity_unit: doc['quanity_unit'],
                           total_price: doc['total_price'],
                           expires_on: Date.parse(doc['expires_on']),
                           extra_info: doc['extra_info'])
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

    private

    def db
      @db ||= CouchRest.database!("http://127.0.0.1:5984/price_api_#{ENV['RACK_ENV']}")
    end
  end
end
