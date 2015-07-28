require 'unit_helper'

require './app/commands/price_entry/location_names_query'
require './spec/unit/commands/price_entry/add_price_command_helper'

describe PriceEntry::LocationNamesQuery do
  include AddPriceCommandHelpers

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    it 'empty array by default'  do
      expect(subject.execute).to eql([])
    end

    it 'returns the location name'  do
      create_price_entry(location: 'World')
      expect(subject.execute).to eql(['World'])
    end

    it 'returns uniq names'  do
      create_price_entry(location: 'Hello')
      create_price_entry(location: 'Test')
      create_price_entry(location: 'Test')
      expect(subject.execute).to eql(%w(Hello Test))
    end
  end
end
