require 'unit_helper'

require './app/models/price_entry/unit_names_query'
require './spec/unit/models/price_entry/add_price_command_helper'

describe PriceEntry::UnitNamesQuery do
  include AddPriceCommandHelpers

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    it 'empty array by default'  do
      expect(subject.execute).to eql([])
    end

    it 'returns the Store name'  do
      create_price_entry(package_unit: 'Hello')
      expect(subject.execute).to eql(['Hello'])
    end

    it 'returns uniq names'  do
      create_price_entry(package_unit: 'Hello')
      create_price_entry(package_unit: 'Test')
      create_price_entry(package_unit: 'Test')
      expect(subject.execute).to eql(%w(Hello Test))
    end
  end
end
