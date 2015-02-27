require 'spec_helper'

require './app/models/price_entry/add_price_command'

describe PriceEntry::AddPriceCommand do
  let(:subject) { PriceEntry::AddPriceCommand }
  let(:last_entry) { DB[:price_entries].order(:id).last }

  before :each do
    DB[:price_entries].truncate
  end

  describe 'execute' do
    let(:default_params) do
      { name: 'Soda', date_on: Date.today, store: 'store', location: 'location', brand: 'brand',
        quanity: 1, quanity_unit: 'Liters', total_price: 12.9,
        expires_on: Date.today + 5, extra_info: 'extra_info' }
    end

    it 'saves the entry to storage'  do
      command = PriceEntry::AddPriceCommand.new(default_params)
      command.execute
      entry_values_without_id = last_entry.tap { |e| e.delete(:id) }
      expect(entry_values_without_id).to eq(default_params)
    end

    it 'sets date_on to past' do
      default_params[:date_on] = Date.today - 1
      command = PriceEntry::AddPriceCommand.new(default_params)
      command.execute
      expect(last_entry[:date_on]).to eq(Date.today - 1)
    end

    it 'sets date_on to today if nil' do
      default_params[:date_on] = nil
      command = PriceEntry::AddPriceCommand.new(default_params)
      command.execute
      expect(last_entry[:date_on]).to eq(Date.today)
    end

    it 'sets date_on to today if blank' do
      default_params[:date_on] = ''
      command = PriceEntry::AddPriceCommand.new(default_params)
      command.execute
      expect(last_entry[:date_on]).to eq(Date.today)
    end
  end
end
