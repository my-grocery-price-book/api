require 'spec_helper'

require './app/models/price_entry/repo'

describe PriceEntry::Repo do
  subject { PriceEntry::Repo.instance }

  before :each do
    PriceEntry::Repo.instance.reset
  end

  describe 'find_or_create_by_name_and_unit' do
    it 'creates a new price_entry' do
      item = subject.find_or_create_by_name_and_unit('Soda', 'Liters')
      expect(item).to be_kind_of(PriceEntry::Item)
      expect([item.name, item.unit, item.prices]).to eq(['Soda', 'Liters', []])
    end
  end

  describe 'save' do
    it 'creates a new price_entry' do
      item = PriceEntry::Item.new(name: 'Weetbix', unit: 'Grams')
      item.add_price(
        date_on: Date.today,
        store: 'Checkers',
        location: 'Canal Walk',
        brand: 'Weetbix',
        quanity: 500,
        total_price: 50
      )
      subject.save(item)
      saved_item = subject.find_or_create_by_name_and_unit('Weetbix', 'Grams')
      expect([saved_item.name, saved_item.unit, saved_item.prices])
        .to eq([item.name, item.unit, item.prices])
    end
  end

  describe 'all_as_array_hash' do
    it 'returns array_hash' do
      item = PriceEntry::Item.new(name: 'Weetbix', unit: 'Grams')
      item.add_price(
        date_on: Date.today,
        store: 'Checkers',
        location: 'Canal Walk',
        brand: 'Weetbix',
        quanity: 500,
        total_price: 50
      )
      subject.save(item)
      expect(subject.all_as_array_hash)
        .to eq([{ generic_name: 'Weetbix', quanity_unit: 'Grams',
                  prices: [{ date_on: Date.today,
                             store: 'Checkers',
                             location: 'Canal Walk',
                             brand: 'Weetbix',
                             quanity: 500,
                             total_price: 50,
                             expires_on: nil,
                             extra_info: nil }] }])
    end
  end
end
