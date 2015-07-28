require 'unit_helper'

require './app/commands/price_entry/store_names_query'
require './spec/unit/commands/price_entry/add_price_command_helper'

describe PriceEntry::StoreNamesQuery do
  include AddPriceCommandHelpers

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    it 'empty array by default'  do
      expect(subject.execute).to eql([])
    end

    it 'returns the Store name'  do
      create_price_entry(store: 'Hello')
      expect(subject.execute).to eql(['Hello'])
    end

    it 'returns uniq names'  do
      create_price_entry(store: 'World')
      create_price_entry(store: 'Test')
      create_price_entry(store: 'Test')
      expect(subject.execute).to eql(%w(Test World))
    end
  end
end
