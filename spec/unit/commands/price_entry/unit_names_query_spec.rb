require 'unit_helper'

require './app/commands/price_entry/unit_names_query'
require './spec/unit/commands/price_entry/add_price_command_helper'

describe PriceEntry::UnitNamesQuery do
  subject { PriceEntry::UnitNamesQuery }

  include AddPriceCommandHelpers

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    def execute(*args)
      subject.new(*args).execute
    end

    it 'empty array by default'  do
      create_price_entry(region: 'za-wc', package_unit: 'Hello')
      expect(execute(region: 'za-nl')).to eql([])
    end

    it 'returns the Store name'  do
      create_price_entry(region: 'za-nl', package_unit: 'Hello')
      expect(execute(region: 'za-nl')).to eql(['Hello'])
    end

    it 'returns uniq names'  do
      create_price_entry(region: 'za-nl', package_unit: 'Hello')
      create_price_entry(region: 'za-nl', package_unit: 'Test')
      create_price_entry(region: 'za-nl', package_unit: 'Test')
      expect(execute(region: 'za-nl').sort).to eql(%w(Hello Test))
    end
  end
end
