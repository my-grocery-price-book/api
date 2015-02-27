require 'spec_helper'

require './app/models/price_entry/products_query'
require './app/models/price_entry/add_price_command'

describe PriceEntry::ProductsQuery do
  describe 'execute' do
    before :each do
      DB[:price_entries].truncate
    end

    let(:default_params) do
      { name: 'Soda', date_on: Date.today, store: 'store', location: 'location', brand: 'brand',
        quanity: 1, quanity_unit: 'Liters', total_price: 12.9,
        expires_on: Date.today + 5, extra_info: 'extra_info' }
    end

    it 'empty array by default'  do
      expect(subject.execute).to eql([])
    end

    it '10 limit default on name'  do
      11.times.each do |i|
        default_params[:name] = "Hello #{i}"
        PriceEntry::AddPriceCommand.new(default_params).execute
      end
      expect(subject.execute.map { |p| p[:name] }).to eql(['Hello 0', 'Hello 1', 'Hello 2', 'Hello 3',
                                                           'Hello 4', 'Hello 5', 'Hello 6', 'Hello 7',
                                                           'Hello 8', 'Hello 9'])
    end

    it '10 limit default on quanity_unit' do
      11.times.each do |i|
        default_params[:quanity_unit] = "Hello #{i}"
        PriceEntry::AddPriceCommand.new(default_params).execute
      end
      expect(subject.execute.map { |p| p[:quanity_unit] }).to eql(['Hello 0', 'Hello 1', 'Hello 2', 'Hello 3',
                                                                   'Hello 4', 'Hello 5', 'Hello 6', 'Hello 7',
                                                                   'Hello 8', 'Hello 9'])
    end

    it '10 limit default on quanity_unit and name' do
      4.times.each do |i|
        default_params[:name] = "N#{i}"
        4.times.each do |j|
          default_params[:quanity_unit] = "Q#{j}"
          PriceEntry::AddPriceCommand.new(default_params).execute
        end
      end
      name_and_quanity_unit_array = subject.execute.map { |p| p[:name] + p[:quanity_unit] }
      expect(name_and_quanity_unit_array).to eql(%w(N0Q0 N0Q1 N0Q2 N0Q3 N1Q0 N1Q1 N1Q2 N1Q3 N2Q0 N2Q1))
    end

    it '3 price limit'  do
      4.times.each do |i|
        default_params[:location] = "Hello #{i}"
        PriceEntry::AddPriceCommand.new(default_params).execute
      end
      expect(subject.execute.first[:prices]).to eql([{ name: 'Soda', store: 'store', location: 'Hello 0',
                                                       brand: 'brand', quanity: 1.0, quanity_unit: 'Liters',
                                                       total_price: 12.9, date_on: Date.today,
                                                       expires_on: (Date.today + 5), extra_info: 'extra_info' },
                                                     { name: 'Soda', store: 'store', location: 'Hello 1',
                                                       brand: 'brand', quanity: 1.0, quanity_unit: 'Liters',
                                                       total_price: 12.9, date_on: Date.today,
                                                       expires_on: (Date.today + 5), extra_info: 'extra_info' },
                                                     { name: 'Soda', store: 'store', location: 'Hello 2',
                                                       brand: 'brand', quanity: 1.0, quanity_unit: 'Liters',
                                                       total_price: 12.9, date_on: Date.today,
                                                       expires_on: (Date.today + 5), extra_info: 'extra_info' }])
    end

    it '3 price limit'  do
      4.times.each do |i|
        default_params[:name] = "N#{i}"
        4.times.each do |j|
          default_params[:quanity_unit] = "Q#{j}"
          4.times.each do |k|
            default_params[:location] = "Hello #{k}"
            PriceEntry::AddPriceCommand.new(default_params).execute
          end
        end
      end
      expect(subject.execute.last[:prices]).to eql([{ name: 'N2', store: 'store', location: 'Hello 0',
                                                      brand: 'brand', quanity: 1.0, quanity_unit: 'Q1',
                                                      total_price: 12.9, date_on: Date.today,
                                                      expires_on: (Date.today + 5), extra_info: 'extra_info' },
                                                    { name: 'N2', store: 'store', location: 'Hello 1',
                                                      brand: 'brand', quanity: 1.0, quanity_unit: 'Q1',
                                                      total_price: 12.9, date_on: Date.today,
                                                      expires_on: (Date.today + 5), extra_info: 'extra_info' },
                                                    { name: 'N2', store: 'store', location: 'Hello 2',
                                                      brand: 'brand', quanity: 1.0, quanity_unit: 'Q1',
                                                      total_price: 12.9, date_on: Date.today,
                                                      expires_on: (Date.today + 5), extra_info: 'extra_info' }])
    end
  end
end
