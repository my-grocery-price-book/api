require 'spec_helper'

require './app/models/price_entry/repo'
require './app/models/price_entry/item'

describe PriceEntry::Repo do
  subject { PriceEntry::Repo.instance }

  let(:price_entry) do
    PriceEntry::Item.new(generic_name: 'Soda',
                         date_on: Date.today,
                         store: 'Pick n Pay',
                         location: 'Canal Walk',
                         brand: 'Coke',
                         quanity: 2,
                         quanity_unit: 'Liters',
                         total_price: 13.99,
                         expires_on: Date.today + 1,
                         extra_info: 'Cooldrink')
  end


  describe 'create' do
    it 'stores a single entry' do
      price_entry_id = subject.create(price_entry)
      stored_price_entry = subject.find_by_id(price_entry_id)
      expect(stored_price_entry.to_hash).to eq(price_entry.to_hash)
    end
  end
end
