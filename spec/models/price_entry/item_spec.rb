require 'spec_helper'

require './app/models/price_entry/item'  # <-- your sinatra app

describe PriceEntry::Item do
  subject { PriceEntry::Item.new(name: 'Soda', unit: 'Liters') }

  describe 'initialize' do
    it 'sets name' do
      expect(subject.name).to eq('Soda')
    end

    it 'sets unit' do
      expect(subject.unit).to eq('Liters')
    end
  end

  describe 'add_price' do
    it 'sets name' do
      subject.add_price(date_on: Date.today,
                        store: 'Pick n Pay',
                        location: 'Canal Walk',
                        brand: 'Coke',
                        quanity: 2,
                        total_price: 13.99,
                        expires_on: Date.today + 1,
                        extra_info: 'Cooldrink' )
      expect(subject.prices).to eq([{date_on: Date.today,
                                    store: 'Pick n Pay',
                                    location: 'Canal Walk',
                                    brand: 'Coke',
                                    quanity: 2,
                                    total_price: 13.99,
                                    expires_on: Date.today + 1,
                                    extra_info: 'Cooldrink'}])
    end
  end
end
