require 'unit_helper'

require './app/commands/price_entry/product_brand_names_query'
require './spec/unit/commands/price_entry/add_price_command_helper'

describe PriceEntry::ProductBrandNamesQuery do
  include AddPriceCommandHelpers
  subject { PriceEntry::ProductBrandNamesQuery }

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    def execute(*args)
      subject.new(*args).execute
    end

    it 'empty array by default'  do
      create_price_entry(region: 'za-wc', product_brand_name: 'World')
      expect(execute(region: 'za-ec', search_text: nil)).to eql([])
    end

    it 'returns the brand name'  do
      create_price_entry(region: 'za-ec', product_brand_name: 'World')
      expect(execute(region: 'za-ec', search_text: nil)).to eql(['World'])
    end

    it 'returns uniq names' do
      create_price_entry(region: 'za-ec', product_brand_name: 'Hello')
      create_price_entry(region: 'za-ec', product_brand_name: 'Test')
      create_price_entry(region: 'za-ec', product_brand_name: 'Test')
      expect(execute(region: 'za-ec', search_text: nil).sort).to eql(%w(Hello Test))
    end

    it 'limits at 20 entries' do
      21.times do |i|
        create_price_entry(region: 'za-ec', product_brand_name: 'Hello' + i.to_s)
      end
      expect(execute(region: 'za-ec', search_text: nil).size).to eql(20)
    end

    it 'allows you to search for Hello using first character' do
      create_price_entry(region: 'za-ec', product_brand_name: 'Hello')
      create_price_entry(region: 'za-ec', product_brand_name: 'Test')
      expect(execute(region: 'za-ec', search_text: 'H')).to eql(%w(Hello))
    end

    it 'allows you to search for Hello using last character' do
      create_price_entry(region: 'za-ec', product_brand_name: 'Hello')
      create_price_entry(region: 'za-ec', product_brand_name: 'Test')
      expect(execute(region: 'za-ec', search_text: 'o')).to eql(%w(Hello))
    end
  end
end
