require 'spec_helper'

require './app/models/price_entry/unit_names_query'
require './app/models/price_entry/add_price_command'

describe PriceEntry::UnitNamesQuery do
  describe 'execute' do
    before :each do
      DB[:price_entries].truncate
    end

    let(:default_params) do
      { name: 'Soda', date_on: Date.today, store: 'store', location: 'location', brand: 'brand',
        quanity: 1, quanity_unit: 'Liters', total_price: 12.9,
        expires_on: Date.today + 5, extra_info: 'extra_info' }
    end

    it 'empty array by default'  do
      expect(subject.execute).to eql([])
    end

    it 'returns the Store name'  do
      default_params[:quanity_unit] = 'Hello'
      PriceEntry::AddPriceCommand.new(default_params).execute
      expect(subject.execute).to eql(['Hello'])
    end

    it 'returns uniq names'  do
      default_params[:quanity_unit] = 'Hello'
      PriceEntry::AddPriceCommand.new(default_params).execute
      default_params[:quanity_unit] = 'Test'
      PriceEntry::AddPriceCommand.new(default_params).execute
      default_params[:quanity_unit] = 'Test'
      PriceEntry::AddPriceCommand.new(default_params).execute
      expect(subject.execute).to eql(%w(Hello Test))
    end
  end
end
