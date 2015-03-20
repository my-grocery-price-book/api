require 'spec_helper'

require './app/models/price_entry/products_query'
require './app/models/price_entry/add_price_command'

describe PriceEntry::ProductsQuery do
  subject { PriceEntry::ProductsQuery }

  describe 'execute' do
    before :each do
      DB[:price_entries].truncate
    end

    let(:default_params) do
      { generic_name: 'Soda', date_on: Date.today, store: 'store', location: 'location',
        product_brand_name: 'Diet Coke', quanity: 1, quanity_unit: 'Liters', total_price: 12.9,
        expires_on: Date.today + 5, extra_info: 'extra_info' }
    end

    it 'empty array by default'  do
      expect(subject.new.execute).to eql([])
    end

    it 'search text 0'  do
      3.times.each do |i|
        default_params[:generic_name] = "Hello #{i}"
        PriceEntry::AddPriceCommand.new(default_params).execute
      end
      expect(subject.new(search_string: '0').execute.map { |p| p[:generic_name] }).to eql(['Hello 0'])
    end

    it 'search text'  do
      12.times.each do |i|
        default_params[:generic_name] = "#{i}Hello"
        PriceEntry::AddPriceCommand.new(default_params).execute
      end
      expect(subject.new(search_string: '1Hello').execute.map { |p| p[:generic_name] }).to eql(%w(1Hello 11Hello))
    end

    it '5 limit'  do
      11.times.each do |i|
        default_params[:generic_name] = "Hello #{i}"
        PriceEntry::AddPriceCommand.new(default_params).execute
      end
      expect(subject.new(limit: 5).execute.map { |p| p[:generic_name] }).to eql(['Hello 0', 'Hello 1', 'Hello 2',
                                                                                 'Hello 3', 'Hello 4'])
    end

    it '10 limit default on name'  do
      11.times.each do |i|
        default_params[:generic_name] = "Hello #{i}"
        PriceEntry::AddPriceCommand.new(default_params).execute
      end
      expect(subject.new.execute.map { |p| p[:generic_name] }).to eql(['Hello 0', 'Hello 1', 'Hello 2', 'Hello 3',
                                                                       'Hello 4', 'Hello 5', 'Hello 6', 'Hello 7',
                                                                       'Hello 8', 'Hello 9'])
    end

    it '10 limit default on quanity_unit' do
      11.times.each do |i|
        default_params[:quanity_unit] = "Hello #{i}"
        PriceEntry::AddPriceCommand.new(default_params).execute
      end
      expect(subject.new.execute.map { |p| p[:quanity_unit] }).to eql(['Hello 0', 'Hello 1', 'Hello 2', 'Hello 3',
                                                                       'Hello 4', 'Hello 5', 'Hello 6', 'Hello 7',
                                                                       'Hello 8', 'Hello 9'])
    end

    it '10 limit default on quanity_unit and name' do
      4.times.each do |i|
        default_params[:generic_name] = "N#{i}"
        4.times.each do |j|
          default_params[:quanity_unit] = "Q#{j}"
          PriceEntry::AddPriceCommand.new(default_params).execute
        end
      end
      name_and_quanity_unit_array = subject.new.execute.map { |p| p[:generic_name] + p[:quanity_unit] }
      expect(name_and_quanity_unit_array).to eql(%w(N0Q0 N0Q1 N0Q2 N0Q3 N1Q0 N1Q1 N1Q2 N1Q3 N2Q0 N2Q1))
    end

    it '3 price limit'  do
      4.times.each do |i|
        default_params[:location] = "Hello #{i}"
        PriceEntry::AddPriceCommand.new(default_params).execute
      end
      expect(subject.new.execute.first[:prices]).to eql([{ generic_name: 'Soda', store: 'store', location: 'Hello 0',
                                                           product_brand_name: 'Diet Coke', quanity: 1.0, sets_of: 1,
                                                           quanity_unit: 'Liters', total_price: 12.9,
                                                           date_on: Date.today, expires_on: (Date.today + 5),
                                                           extra_info: 'extra_info' },
                                                         { generic_name: 'Soda', store: 'store', location: 'Hello 1',
                                                           product_brand_name: 'Diet Coke', quanity: 1.0, sets_of: 1,
                                                           quanity_unit: 'Liters', total_price: 12.9,
                                                           date_on: Date.today, expires_on: (Date.today + 5),
                                                           extra_info: 'extra_info' },
                                                         { generic_name: 'Soda', store: 'store', location: 'Hello 2',
                                                           product_brand_name: 'Diet Coke', quanity: 1.0, sets_of: 1,
                                                           quanity_unit: 'Liters', total_price: 12.9,
                                                           date_on: Date.today, expires_on: (Date.today + 5),
                                                           extra_info: 'extra_info' }])
    end

    it '3 price limit'  do
      4.times.each do |i|
        default_params[:generic_name] = "N#{i}"
        4.times.each do |j|
          default_params[:quanity_unit] = "Q#{j}"
          4.times.each do |k|
            default_params[:location] = "Hello #{k}"
            PriceEntry::AddPriceCommand.new(default_params).execute
          end
        end
      end
      expect(subject.new.execute.last[:prices]).to eql([{ generic_name: 'N2', store: 'store', location: 'Hello 0',
                                                          product_brand_name: 'Diet Coke', quanity: 1.0,
                                                          quanity_unit: 'Q1', total_price: 12.9, date_on: Date.today,
                                                          sets_of: 1, expires_on: (Date.today + 5),
                                                          extra_info: 'extra_info' },
                                                        { generic_name: 'N2', store: 'store', location: 'Hello 1',
                                                          product_brand_name: 'Diet Coke', quanity: 1.0,
                                                          quanity_unit: 'Q1', total_price: 12.9, date_on: Date.today,
                                                          sets_of: 1, expires_on: (Date.today + 5),
                                                          extra_info: 'extra_info' },
                                                        { generic_name: 'N2', store: 'store', location: 'Hello 2',
                                                          product_brand_name: 'Diet Coke', quanity: 1.0,
                                                          quanity_unit: 'Q1', total_price: 12.9, date_on: Date.today,
                                                          sets_of: 1, expires_on: (Date.today + 5),
                                                          extra_info: 'extra_info' }])
    end
  end
end
