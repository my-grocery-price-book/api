require 'unit_helper'

require './app/models/price_entry/products_query'
require './spec/unit/models/price_entry/add_price_command_helper'

describe PriceEntry::ProductsQuery do
  include AddPriceCommandHelpers
  subject { PriceEntry::ProductsQuery }

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    it 'empty array by default'  do
      expect(subject.new.execute).to eql([])
    end

    it 'search text end of string'  do
      6.times.each do |i|
        create_price_entry(generic_name: "Hello#{i * 2}")
      end
      expect(subject.new(search_string: '0').execute.map { |p| p[:generic_name] }).to eql(%w(Hello0 Hello10))
    end

    it 'search text start of string'  do
      6.times.each do |i|
        create_price_entry(generic_name: "#{i * 2}Hello")
      end
      expect(subject.new(search_string: '0Hello').execute.map { |p| p[:generic_name] }).to eql(%w(0Hello 10Hello))
    end

    it 'search text inside of string'  do
      6.times.each do |i|
        create_price_entry(generic_name: "Hel#{i * 2}lo")
      end
      expect(subject.new(search_string: '0l').execute.map { |p| p[:generic_name] }).to eql(%w(Hel0lo Hel10lo))
    end

    it '5 limit'  do
      6.times.each do |i|
        create_price_entry(generic_name: "Hello #{i}")
      end
      expect(subject.new(limit: 5).execute.map { |p| p[:generic_name] }).to eql(['Hello 0', 'Hello 1', 'Hello 2',
                                                                                 'Hello 3', 'Hello 4'])
    end

    it '10 limit default on name'  do
      11.times.each do |i|
        create_price_entry(generic_name: "Hello #{i}")
      end
      expect(subject.new.execute.map { |p| p[:generic_name] }).to eql(['Hello 0', 'Hello 1', 'Hello 10', 'Hello 2',
                                                                       'Hello 3', 'Hello 4', 'Hello 5', 'Hello 6',
                                                                       'Hello 7', 'Hello 8'])
    end

    it '10 limit default on name with blank limit'  do
      11.times.each do |i|
        create_price_entry(generic_name: "Hello #{i}")
      end
      generic_names = subject.new(limit: '').execute.map { |p| p[:generic_name] }
      expect(generic_names).to eql(['Hello 0', 'Hello 1', 'Hello 10', 'Hello 2', 'Hello 3', 'Hello 4',
                                    'Hello 5', 'Hello 6', 'Hello 7', 'Hello 8'])
    end

    it '10 limit default on package_unit' do
      11.times.each do |i|
        create_price_entry(package_unit: "Hello #{i}")
      end
      expect(subject.new.execute.map { |p| p[:package_unit] }).to eql(['Hello 0', 'Hello 1', 'Hello 10', 'Hello 2',
                                                                       'Hello 3', 'Hello 4', 'Hello 5', 'Hello 6',
                                                                       'Hello 7', 'Hello 8'])
    end

    it '10 limit default on package_unit and name' do
      4.times.each do |i|
        4.times.each do |j|
          create_price_entry(generic_name: "N#{i}", package_unit: "Q#{j}")
        end
      end
      name_and_package_unit_array = subject.new.execute.map { |p| p[:generic_name] + p[:package_unit] }
      expect(name_and_package_unit_array).to eql(%w(N0Q0 N0Q1 N0Q2 N0Q3 N1Q0 N1Q1 N1Q2 N1Q3 N2Q0 N2Q1))
    end

    it '3 price limit'  do
      4.times.each do |i|
        create_price_entry(location: "Hello #{i}")
      end
      expect(subject.new.execute.first[:prices]).to eql([{ generic_name: 'Soda', store: 'Pick n Pay',
                                                           location: 'Hello 0', product_brand_name: 'Coke',
                                                           quanity: 6.0, package_unit: 'ml', total_price: 38.99,
                                                           date_on: Date.today, expires_on: nil, extra_info: nil,
                                                           package_type: 'Cans', package_size: 340,
                                                           category: 'Drinks' },
                                                         { generic_name: 'Soda', store: 'Pick n Pay',
                                                           location: 'Hello 1', product_brand_name: 'Coke',
                                                           quanity: 6.0, package_unit: 'ml', total_price: 38.99,
                                                           date_on: Date.today, expires_on: nil, extra_info: nil,
                                                           package_type: 'Cans', package_size: 340,
                                                           category: 'Drinks' },
                                                         { generic_name: 'Soda', store: 'Pick n Pay',
                                                           location: 'Hello 2', product_brand_name: 'Coke',
                                                           quanity: 6.0, package_unit: 'ml', total_price: 38.99,
                                                           date_on: Date.today, expires_on: nil, extra_info: nil,
                                                           package_type: 'Cans', package_size: 340,
                                                           category: 'Drinks' }
                                                        ])
    end

    it '3 price limit'  do
      4.times.each do |i|
        4.times.each do |j|
          4.times.each do |_k|
            create_price_entry(location: "Hello #{i}", generic_name: "N#{i}", package_unit: "Q#{j}")
          end
        end
      end
      expect(subject.new.execute.last[:prices]).to eql([{ generic_name: 'N2', store: 'Pick n Pay',
                                                          location: 'Hello 2', product_brand_name: 'Coke',
                                                          quanity: 6.0, package_unit: 'Q1', total_price: 38.99,
                                                          date_on: Date.today, expires_on: nil, extra_info: nil,
                                                          package_type: 'Cans', package_size: 340,
                                                          category: 'Drinks' },
                                                        { generic_name: 'N2', store: 'Pick n Pay',
                                                          location: 'Hello 2', product_brand_name: 'Coke',
                                                          quanity: 6.0, package_unit: 'Q1', total_price: 38.99,
                                                          date_on: Date.today, expires_on: nil, extra_info: nil,
                                                          package_type: 'Cans', package_size: 340,
                                                          category: 'Drinks' },
                                                        { generic_name: 'N2', store: 'Pick n Pay',
                                                          location: 'Hello 2', product_brand_name: 'Coke',
                                                          quanity: 6.0, package_unit: 'Q1', total_price: 38.99,
                                                          date_on: Date.today, expires_on: nil, extra_info: nil,
                                                          package_type: 'Cans', package_size: 340,
                                                          category: 'Drinks' }])
    end
  end
end
