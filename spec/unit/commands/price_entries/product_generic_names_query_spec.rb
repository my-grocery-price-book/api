require 'unit_helper'

require './app/commands/price_entries/product_generic_names_query'
require './spec/unit/commands/price_entries/add_price_command_helper'

describe PriceEntries::ProductGenericNamesQuery do
  subject { PriceEntries::ProductGenericNamesQuery }
  include AddPriceCommandHelpers

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    def execute(*args)
      subject.new(*args).execute
    end

    it 'empty array by default' do
      create_price_entry(generic_name: 'Hello', region: 'za-wc')
      expect(execute(region: 'za-nl')).to eql([])
    end

    it 'returns the product name' do
      create_price_entry(generic_name: 'Hello', region: 'za-nl')
      expect(execute(region: 'za-nl')).to eql(['Hello'])
    end

    it 'returns uniq names' do
      create_price_entry(generic_name: 'Hello', region: 'za-nl')
      create_price_entry(generic_name: 'Test', region: 'za-nl')
      create_price_entry(generic_name: 'Test', region: 'za-nl')
      expect(execute(region: 'za-nl').sort).to eql(%w(Hello Test))
    end
  end
end
