require 'spec_helper'

require './app/models/price_entry/item'  # <-- your sinatra app

describe PriceEntry::Item do
  describe 'class methods' do

    let(:valid_attributes) do
      {generic_name: 'Soda',
       date_on: Date.today,
       store: 'Pick n Pay',
       location: 'Canal Walk',
       brand: 'Coke',
       quanity: 2,
       quanity_unit: 'Liters',
       total_price: 13.99,
       expires_on: Date.today + 1,
       extra_info: 'Cooldrink'}
    end

    context 'sets attributes' do
      subject {PriceEntry::Item.new(valid_attributes)}

      it 'sets generic_name' do
          expect(subject.generic_name).to eq('Soda')
      end

      it 'sets date_on' do
        expect(subject.date_on).to eq(Date.today)
      end

      it 'sets store' do
        expect(subject.store).to eq('Pick n Pay')
      end

      it 'sets location' do
        expect(subject.location).to eq('Canal Walk')
      end

      it 'sets brand' do
        expect(subject.brand).to eq('Coke')
      end

      it 'sets quanity' do
        expect(subject.quanity).to eq(2)
      end

      it 'sets quanity_unit' do
        expect(subject.quanity_unit).to eq('Liters')
      end

      it 'sets total_price' do
        expect(subject.total_price).to eq(13.99)
      end

      it 'sets expires_on' do
        expect(subject.expires_on).to eq(Date.today + 1)
      end

      it 'sets extra_info' do
        expect(subject.expires_on).to eq(Date.today + 1)
      end
    end
  end
end
