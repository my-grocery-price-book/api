require 'unit_helper'

require './app/commands/price_entries/prices_query'
require './spec/unit/commands/price_entries/add_price_command_helper'

describe PriceEntries::PricesQuery do
  include AddPriceCommandHelpers
  subject { PriceEntries::PricesQuery }

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    def execute(region: 'za-wc', limit: nil, search_string: nil, product_brand_names: nil)
      subject.new(region: region, limit: limit,
                  search_string: search_string,
                  product_brand_names: product_brand_names).execute
    end

    it 'empty array by default' do
      expect(execute).to eql([])
    end

    it 'regions only 1 region' do
      create_price_entry(product_brand_name: 'p1', region: 'za-ec')
      create_price_entry(product_brand_name: 'p2', region: 'za-wc')
      create_price_entry(product_brand_name: 'p3', region: 'za-ec')

      product_brand_names = execute(region: 'za-ec').map { |p| p[:product_brand_name] }.sort

      expect(product_brand_names).to eql(%w(p1 p3))
    end

    it 'search text end of string' do
      6.times.each do |i|
        create_price_entry(product_brand_name: "Hello#{i * 2}")
      end
      product_brand_names = execute(search_string: '0').map { |p| p[:product_brand_name] }
      expect(product_brand_names.sort).to eql(%w(Hello0 Hello10))
    end

    it 'search text start of string' do
      6.times.each do |i|
        create_price_entry(product_brand_name: "#{i * 2}Hello")
      end
      product_brand_names = execute(search_string: '0Hello').map { |p| p[:product_brand_name] }
      expect(product_brand_names.sort).to eql(%w(0Hello 10Hello))
    end

    it 'search text inside of string' do
      6.times.each do |i|
        create_price_entry(product_brand_name: "Hel#{i * 2}lo")
      end
      product_brand_names = execute(search_string: '0l').map { |p| p[:product_brand_name] }
      expect(product_brand_names.sort).to eql(%w(Hel0lo Hel10lo))
    end

    it '5 limit' do
      6.times.each do |i|
        create_price_entry(product_brand_name: "Hello #{i}")
      end
      size = execute(limit: 5).size
      expect(size).to eql(5)
    end

    it '10 limit default on name' do
      11.times.each do |i|
        create_price_entry(product_brand_name: "Hello #{i}")
      end
      size = execute.size
      expect(size).to eql(10)
    end

    it '10 limit default on name with blank limit' do
      11.times.each do |i|
        create_price_entry(product_brand_name: "Hello #{i}")
      end
      size = execute(limit: '').size
      expect(size).to eql(10)
    end

    it 'returns on product_brand_names that match' do
      create_price_entry(product_brand_name: 'p1', region: 'za-wc')
      create_price_entry(product_brand_name: 'p2', region: 'za-wc')
      create_price_entry(product_brand_name: 'p3', region: 'za-wc')

      product_brand_names = execute(product_brand_names: %w(p2 p3)).map { |p| p[:product_brand_name] }.sort

      expect(product_brand_names).to eql(%w(p2 p3))
    end
  end
end
