require 'unit_helper'
require 'active_support/core_ext/hash/except'

require './app/models/price_entry'
require './app/commands/price_entries/add_price_command'

describe PriceEntries::AddPriceCommand do
  let(:subject) { PriceEntries::AddPriceCommand }
  let(:last_entry) { DB[:price_entries].order(:id).last }

  before :each do
    DB[:price_entries].truncate
  end

  describe 'execute' do
    let(:default_values) do
      { date_on: Date.today, store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
        generic_name: 'Soda', package_size: 340, package_unit: 'ml', category: 'Drinks',
        quantity: 2, total_price: 18.99, region: 'za-wc' }
    end

    it 'saves the entry to storage' do
      command = subject.new(price_entry_params: default_values, price_entries: DB[:price_entries])
      command.execute
      entry_values = last_entry.except(:id, :price_per_package_unit)
      expect(entry_values).to eq(default_values)
    end

    it 'sets price_per_package_unit' do
      command = subject.new(price_entry_params: default_values, price_entries: DB[:price_entries])
      command.execute
      price_per_package_unit = last_entry[:price_per_package_unit]
      expect(price_per_package_unit).to be_within(0.0001).of(0.0279264)
    end

    it 'sets date_on to past' do
      default_values[:date_on] = Date.today - 1
      command = subject.new(price_entry_params: default_values, price_entries: DB[:price_entries])
      command.execute
      expect(last_entry[:date_on]).to eq(Date.today - 1)
    end

    it 'can save fractional package_size' do
      default_values[:package_size] = 1.5
      command = subject.new(price_entry_params: default_values, price_entries: DB[:price_entries])
      command.execute
      expect(last_entry[:package_size]).to eq(1.5)
    end
  end
end
