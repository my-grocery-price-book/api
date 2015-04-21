require 'spec_helper'

require './app/models/price_entry/product_generic_names_query'
require './spec/unit/models/price_entry/add_price_command_helper'

describe PriceEntry::ProductGenericNamesQuery do
  include AddPriceCommandHelpers

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    it 'empty array by default'  do
      expect(subject.execute).to eql([])
    end

    it 'returns the product name'  do
      create_price_entry(generic_name: 'Hello')
      expect(subject.execute).to eql(['Hello'])
    end

    it 'returns uniq names'  do
      create_price_entry(generic_name: 'Hello')
      create_price_entry(generic_name: 'Test')
      create_price_entry(generic_name: 'Test')
      expect(subject.execute).to eql(%w(Hello Test))
    end
  end
end
