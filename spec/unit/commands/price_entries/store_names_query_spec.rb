require 'unit_helper'

require './app/commands/price_entries/store_names_query'
require './spec/unit/commands/price_entries/add_price_command_helper'

describe PriceEntries::StoreNamesQuery do
  subject { PriceEntries::StoreNamesQuery }
  include AddPriceCommandHelpers

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    def execute(*args)
      subject.new(*args).execute
    end

    it 'empty array by default' do
      create_price_entry(region: 'za-wc', store: 'Hello')
      expect(execute(region: 'za-ec')).to eql([])
    end

    it 'returns the Store name' do
      create_price_entry(region: 'za-ec', store: 'Hello')
      expect(execute(region: 'za-ec')).to eql(['Hello'])
    end

    it 'returns uniq names' do
      create_price_entry(region: 'za-ec', store: 'World')
      create_price_entry(region: 'za-ec', store: 'Test')
      create_price_entry(region: 'za-ec', store: 'Test')
      expect(execute(region: 'za-ec')).to eql(%w(Test World))
    end
  end
end
