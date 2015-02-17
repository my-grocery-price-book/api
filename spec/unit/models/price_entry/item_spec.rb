require 'spec_helper'

require './app/models/price_entry/item'

describe PriceEntry::Item do
  subject { PriceEntry::Item.new(name: 'Soda', unit: 'Liters') }

  describe 'initialize' do
    it 'sets name' do
      expect(subject.name).to eq('Soda')
    end

    it 'sets unit' do
      expect(subject.unit).to eq('Liters')
    end

    it 'sets empty prices' do
      expect(subject.prices).to eq([])
    end

    it 'sets prices' do
      price = { date_on: Date.today,
                store: 'store',
                location: 'location',
                brand: 'brand',
                quanity: 'quanity',
                total_price: 'total_price',
                expires_on: 'expires_on',
                extra_info: 'extra_info' }
      item = PriceEntry::Item.new(name: 'Soda', unit: 'Liters', prices: [price])
      expect(item.prices).to eq([price])
    end
  end

  describe 'add_price' do
    it 'sets name' do
      price = { date_on: Date.today,
                store: 'Pick n Pay',
                location: 'Canal Walk',
                brand: 'Coke',
                quanity: 2,
                total_price: 13.99,
                expires_on: Date.today + 1,
                extra_info: 'Cooldrink' }
      item = PriceEntry::Item.new(name: 'Soda', unit: 'Liters')
      item.add_price(price)
      expect(item.prices).to eq([price])
    end
  end
end
