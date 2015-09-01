require 'unit_helper'

require './app/commands/price_entries/products_query'
require './spec/unit/commands/price_entries/add_price_command_helper'

describe PriceEntries::ProductsQuery do
  include AddPriceCommandHelpers
  subject { PriceEntries::ProductsQuery }

  describe 'execute' do
    before :each do
      truncate_price_entries
    end

    def default_price_attributes(new_params)
      { generic_name: 'Soda', store: 'Spar', location: 'Goodwood',
        product_brand_name: 'Coke', quantity: 1, package_unit: 'L', total_price: 10.0,
        date_on: Date.today, package_size: 2.0,
        category: 'Drinks', region: 'za-wc' }.merge(new_params)
    end

    def execute(*args)
      subject.new(*args).execute
    end

    it 'empty array by default'  do
      create_price_entry(region: 'za-ec')
      expect(execute(region: 'za-wc', term: nil)).to eql([])
    end

    it 'returns a single price_entry' do
      price_params = default_price_attributes(product_brand_name: 'Coke',
                                              package_unit: 'L', package_size: 2.0,
                                              quantity: 1, total_price: 10.0,
                                              date_on: Date.today)
      create_price_entry(price_params)
      price_params.merge!(price_per_package_unit: 5.0)
      results = execute(region: 'za-wc', term: nil)
      expect(results).to eql([
        product: 'Coke', package_unit: 'L',
        cheapest_last_week: price_params,
        cheapest_last_month: price_params,
        cheapest_last_year: price_params
      ])
    end

    it 'returns best price_per_package_unit' do
      price_params1 = default_price_attributes(product_brand_name: 'Coke',
                                               package_unit: 'L', package_size: 2.0,
                                               quantity: 1, total_price: 20.0,
                                               date_on: Date.today)
      create_price_entry(price_params1)
      price_params = default_price_attributes(product_brand_name: 'Coke',
                                              package_unit: 'L', package_size: 2.0,
                                              quantity: 1, total_price: 10.0,
                                              date_on: Date.today)
      create_price_entry(price_params)
      price_params.merge!(price_per_package_unit: 5.0)
      results = execute(region: 'za-wc', term: nil)
      expect(results).to eql([
        product: 'Coke', package_unit: 'L',
        cheapest_last_week: price_params,
        cheapest_last_month: price_params,
        cheapest_last_year: price_params
      ])
    end

    it 'returns best price_per_package_unit for last week' do
      price_params2 = default_price_attributes(product_brand_name: 'Coke',
                                               package_unit: 'L', package_size: 2.0,
                                               quantity: 1, total_price: 22.0,
                                               date_on: Date.today)
      create_price_entry(price_params2)
      price_params1 = default_price_attributes(product_brand_name: 'Coke',
                                               package_unit: 'L', package_size: 2.0,
                                               quantity: 1, total_price: 20.0,
                                               date_on: Date.today - 6)
      create_price_entry(price_params1)
      price_params = default_price_attributes(product_brand_name: 'Coke',
                                              package_unit: 'L', package_size: 2.0,
                                              quantity: 1, total_price: 10.0,
                                              date_on: Date.today - 7)
      create_price_entry(price_params)
      price_params1.merge!(price_per_package_unit: 10.0)
      price_params.merge!(price_per_package_unit: 5.0)
      results = execute(region: 'za-wc', term: nil)
      expect(results).to eql([
        product: 'Coke', package_unit: 'L',
        cheapest_last_week: price_params1,
        cheapest_last_month: price_params,
        cheapest_last_year: price_params
      ])
    end

    it 'returns best price_per_package_unit for last month' do
      price_params2 = default_price_attributes(product_brand_name: 'Coke',
                                               package_unit: 'L', package_size: 2.0,
                                               quantity: 1, total_price: 22.0,
                                               date_on: Date.today)
      create_price_entry(price_params2)
      price_params1 = default_price_attributes(product_brand_name: 'Coke',
                                               package_unit: 'L', package_size: 2.0,
                                               quantity: 1, total_price: 20.0,
                                               date_on: Date.today - 29)
      create_price_entry(price_params1)
      price_params = default_price_attributes(product_brand_name: 'Coke',
                                              package_unit: 'L', package_size: 2.0,
                                              quantity: 1, total_price: 10.0,
                                              date_on: Date.today - 30)
      create_price_entry(price_params)
      price_params2.merge!(price_per_package_unit: 11.0)
      price_params1.merge!(price_per_package_unit: 10.0)
      price_params.merge!(price_per_package_unit: 5.0)
      results = execute(region: 'za-wc', term: nil)
      expect(results).to eql([
        product: 'Coke', package_unit: 'L',
        cheapest_last_week: price_params2,
        cheapest_last_month: price_params1,
        cheapest_last_year: price_params
      ])
    end

    it 'returns best price_per_package_unit for last year' do
      price_params2 = default_price_attributes(product_brand_name: 'Coke',
                                               package_unit: 'L', package_size: 2.0,
                                               quantity: 1, total_price: 22.0,
                                               date_on: Date.today)
      create_price_entry(price_params2)
      price_params1 = default_price_attributes(product_brand_name: 'Coke',
                                               package_unit: 'L', package_size: 2.0,
                                               quantity: 1, total_price: 20.0,
                                               date_on: Date.today - 364)
      create_price_entry(price_params1)
      price_params = default_price_attributes(product_brand_name: 'Coke',
                                              package_unit: 'L', package_size: 2.0,
                                              quantity: 1, total_price: 10.0,
                                              date_on: Date.today - 365)
      create_price_entry(price_params)
      price_params2.merge!(price_per_package_unit: 11.0)
      price_params1.merge!(price_per_package_unit: 10.0)
      results = execute(region: 'za-wc', term: nil)
      expect(results).to eql([
        product: 'Coke', package_unit: 'L',
        cheapest_last_week: price_params2,
        cheapest_last_month: price_params2,
        cheapest_last_year: price_params1
      ])
    end

    it 'returns a multiple price_entries' do
      price_params = default_price_attributes(product_brand_name: 'Coke',
                                              package_unit: 'L', package_size: 2.0,
                                              quantity: 1, total_price: 10.0,
                                              date_on: Date.today)
      create_price_entry(price_params)
      price_params.merge!(price_per_package_unit: 5.0)
      price_params1 = default_price_attributes(product_brand_name: 'Bread',
                                               package_unit: 'Grams', package_size: 700.0,
                                               quantity: 1, total_price: 7.0,
                                               date_on: Date.today)
      create_price_entry(price_params1)
      price_params1.merge!(price_per_package_unit: 0.01)
      results = execute(region: 'za-wc', term: nil)
      expect(results).to eql([
        {
          product: 'Bread', package_unit: 'Grams',
          cheapest_last_week: price_params1,
          cheapest_last_month: price_params1,
          cheapest_last_year: price_params1 },
        { product: 'Coke', package_unit: 'L',
          cheapest_last_week: price_params,
          cheapest_last_month: price_params,
          cheapest_last_year: price_params }
      ])
    end

    it 'ignores entries older than 1 year' do
      price_params = default_price_attributes(date_on: Date.today - 366)
      create_price_entry(price_params)
      results = execute(region: 'za-wc', term: nil)
      expect(results).to eql([])
    end

    it 'returns best price_per_package_unit if only last year' do
      price_params = default_price_attributes(product_brand_name: 'Coke',
                                              package_unit: 'L', package_size: 2.0,
                                              quantity: 1, total_price: 10.0,
                                              date_on: Date.today - 36)
      create_price_entry(price_params)
      price_params.merge!(price_per_package_unit: 5.0)
      results = execute(region: 'za-wc', term: nil)
      expect(results).to eql([
        product: 'Coke', package_unit: 'L',
        cheapest_last_week: nil,
        cheapest_last_month: nil,
        cheapest_last_year: price_params
      ])
    end

    it 'returns a only 10 products based on product_brand_name' do
      11.times do |product_number|
        price_params = default_price_attributes(product_brand_name: "Cooldrink #{product_number}")
        create_price_entry(price_params)
      end
      results = execute(region: 'za-wc', term: nil)
      expect(results.size).to eql(10)
    end

    it 'returns a only 10 products based on package_unit' do
      11.times do |product_number|
        price_params = default_price_attributes(package_unit: "ml#{product_number}")
        create_price_entry(price_params)
      end
      results = execute(region: 'za-wc', term: nil)
      expect(results.size).to eql(10)
    end

    it 'returns products based on product_brand_name match' do
      price_params = default_price_attributes(product_brand_name: 'Cooldrink')
      create_price_entry(price_params)
      price_params = default_price_attributes(product_brand_name: 'Other')
      create_price_entry(price_params)
      price_params = default_price_attributes(product_brand_name: 'FizzCool')
      create_price_entry(price_params)
      price_params = default_price_attributes(product_brand_name: 'FizzCooling')
      create_price_entry(price_params)
      product_brand_names = subject.new(region: 'za-wc', term: 'Cool').execute.map { |item| item[:product] }
      expect(product_brand_names.sort).to eql(%w(Cooldrink FizzCool FizzCooling))
    end
  end
end
