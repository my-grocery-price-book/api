require 'unit_helper'

require './app/commands/price_entries/location_names_query'
require './spec/unit/commands/price_entries/add_price_command_helper'

describe PriceEntries::LocationNamesQuery do
  subject { PriceEntries::LocationNamesQuery }
  include AddPriceCommandHelpers

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    def execute(region:)
      subject.new(region: region).execute
    end

    it 'empty array by default' do
      expect(execute(region: 'za-wc')).to eql([])
    end

    it 'returns the location name for region' do
      create_price_entry(location: 'Mars', region: 'za-ec')
      create_price_entry(location: 'World', region: 'za-wc')
      expect(execute(region: 'za-wc')).to eql(['World'])
    end

    it 'returns uniq names' do
      create_price_entry(location: 'Hello', region: 'za-wc')
      create_price_entry(location: 'Test', region: 'za-wc')
      create_price_entry(location: 'Test', region: 'za-wc')
      expect(execute(region: 'za-wc').sort).to eql(%w(Hello Test))
    end
  end
end
