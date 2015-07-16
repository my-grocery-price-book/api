require 'unit_helper'

require './app/models/price_entry/product_brand_names_query'
require './spec/unit/models/price_entry/add_price_command_helper'

describe PriceEntry::ProductBrandNamesQuery do
  include AddPriceCommandHelpers
  subject { PriceEntry::ProductBrandNamesQuery }

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    it 'empty array by default'  do
      expect(subject.new(search_text: nil).execute).to eql([])
    end

    it 'returns the brand name'  do
      create_price_entry(product_brand_name: 'World')
      expect(subject.new(search_text: nil).execute).to eql(['World'])
    end

    it 'returns uniq names'  do
      create_price_entry(product_brand_name: 'Hello')
      create_price_entry(product_brand_name: 'Test')
      create_price_entry(product_brand_name: 'Test')
      expect(subject.new(search_text: nil).execute.sort).to eql(%w(Hello Test))
    end

    it 'limits at 20 entries'  do
      21.times do |i|
        create_price_entry(product_brand_name: 'Hello' + i.to_s)
      end
      expect(subject.new(search_text: nil).execute.size).to eql(20)
    end

    it 'allows you to search for Hello using first character' do
      create_price_entry(product_brand_name: 'Hello')
      create_price_entry(product_brand_name: 'Test')
      expect(subject.new(search_text: 'H').execute).to eql(%w(Hello))
    end

    it 'allows you to search for Hello using last character' do
      create_price_entry(product_brand_name: 'Hello')
      create_price_entry(product_brand_name: 'Test')
      expect(subject.new(search_text: 'o').execute).to eql(%w(Hello))
    end
  end
end
