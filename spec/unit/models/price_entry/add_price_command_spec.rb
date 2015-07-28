require 'unit_helper'
require 'active_support/core_ext/hash/except'

require './app/models/price_entry/add_price_command'

describe PriceEntry::AddPriceCommand do
  let(:subject) { PriceEntry::AddPriceCommand }
  let(:last_entry) { DB[:price_entries].order(:id).last }

  before :each do
    DB[:price_entries].truncate
  end

  describe 'execute' do
    let(:default_params) do
      { date_on: Date.today, store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
        generic_name: 'Soda', package_size: 340, package_unit: 'ml', category: 'Drinks',
        quantity: 6, total_price: 38.99, expires_on: Date.today + 5, extra_info: 'extra_info' }
    end

    it 'saves the entry to storage'  do
      command = PriceEntry::AddPriceCommand.new(default_params)
      command.execute
      entry_values = last_entry.except(:id, :price_per_package_unit)
      expect(entry_values).to eq(default_params)
    end

    it 'sets price_per_package_unit'  do
      command = PriceEntry::AddPriceCommand.new(default_params)
      command.execute
      price_per_package_unit = last_entry[:price_per_package_unit]
      expect(price_per_package_unit).to be_within(0.0001).of(0.1146764)
    end

    it 'sets date_on to past' do
      default_params[:date_on] = Date.today - 1
      command = PriceEntry::AddPriceCommand.new(default_params)
      command.execute
      expect(last_entry[:date_on]).to eq(Date.today - 1)
    end
  end
end
