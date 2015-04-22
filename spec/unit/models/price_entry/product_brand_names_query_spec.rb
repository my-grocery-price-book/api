require 'unit_helper'

require './app/models/price_entry/product_brand_names_query'
require './spec/unit/models/price_entry/add_price_command_helper'

describe PriceEntry::ProductBrandNamesQuery do
  include AddPriceCommandHelpers

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    it 'empty array by default'  do
      expect(subject.execute).to eql([])
    end

    it 'returns the brand name'  do
      create_price_entry(product_brand_name: 'World')
      expect(subject.execute).to eql(['World'])
    end

    it 'returns uniq names'  do
      create_price_entry(product_brand_name: 'Hello')
      create_price_entry(product_brand_name: 'Test')
      create_price_entry(product_brand_name: 'Test')
      expect(subject.execute).to eql(%w(Hello Test))
    end
  end
end
