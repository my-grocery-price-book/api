require 'unit_helper'

require './app/models/price_entry/prices_query'
require './spec/unit/models/price_entry/add_price_command_helper'

describe PriceEntry::PricesQuery do
  include AddPriceCommandHelpers
  subject { PriceEntry::PricesQuery }

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    it 'empty array by default'  do
      expect(subject.new.execute).to eql([])
    end

    it 'search text end of string'  do
      6.times.each do |i|
        create_price_entry(product_brand_name: "Hello#{i * 2}")
      end
      expect(subject.new(search_string: '0').execute.map { |p| p[:product_brand_name] }).to eql(%w(Hello0 Hello10))
    end

    it 'search text start of string'  do
      6.times.each do |i|
        create_price_entry(product_brand_name: "#{i * 2}Hello")
      end
      expect(subject.new(search_string: '0Hello').execute.map { |p| p[:product_brand_name] }).to eql(%w(0Hello 10Hello))
    end

    it 'search text inside of string'  do
      6.times.each do |i|
        create_price_entry(product_brand_name: "Hel#{i * 2}lo")
      end
      expect(subject.new(search_string: '0l').execute.map { |p| p[:product_brand_name] }).to eql(%w(Hel0lo Hel10lo))
    end

    it '5 limit'  do
      6.times.each do |i|
        create_price_entry(product_brand_name: "Hello #{i}")
      end
      expect(subject.new(limit: 5).execute.map { |p| p[:product_brand_name] }).to eql(['Hello 0', 'Hello 1', 'Hello 2',
                                                                                       'Hello 3', 'Hello 4'])
    end

    it '10 limit default on name'  do
      11.times.each do |i|
        create_price_entry(product_brand_name: "Hello #{i}")
      end
      expect(subject.new.execute.map { |p| p[:product_brand_name] }).to eql(['Hello 0', 'Hello 1', 'Hello 2', 'Hello 3',
                                                                             'Hello 4', 'Hello 5', 'Hello 6', 'Hello 7',
                                                                             'Hello 8', 'Hello 9'])
    end

    it '10 limit default on name with blank limit'  do
      11.times.each do |i|
        create_price_entry(product_brand_name: "Hello #{i}")
      end
      product_brand_names = subject.new(limit: '').execute.map { |p| p[:product_brand_name] }
      expect(product_brand_names).to eql(['Hello 0', 'Hello 1', 'Hello 2', 'Hello 3', 'Hello 4',
                                          'Hello 5', 'Hello 6', 'Hello 7', 'Hello 8', 'Hello 9'])
    end
  end
end
