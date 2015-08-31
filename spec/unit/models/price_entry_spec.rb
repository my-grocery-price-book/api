require 'unit_helper'

require_relative '../../../app/models/price_entry'

describe PriceEntry do
  let(:default_attributes) do
    { date_on: '2015-08-25', store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
      generic_name: 'Soda', package_size: '340', package_unit: 'ml', category: 'Drinks', quantity: '6',
      total_price: '38.99', region: 'za-wc' }
  end

  subject { PriceEntry.new(default_attributes) }

  describe 'new' do
    describe 'date_on' do
      it 'sets Date' do
        date = Date.strptime('2015-08-25')
        default_attributes[:date_on] = '2015-08-25'
        expect(subject.date_on).to eq(date)
      end

      it 'can set using Date object' do
        default_attributes[:date_on] = Date.today
        expect(subject.date_on).to eq(Date.today)
      end

      it 'will raise error if key missing' do
        default_attributes.delete(:date_on)
        expect { subject }.to raise_error(ArgumentError, 'missing keyword: date_on')
      end

      it 'will raise error if invalid date' do
        default_attributes[:date_on] = 'ABCD'
        expect { subject }.to raise_error(ArgumentError, 'invalid date')
      end
    end

    describe 'store' do
      it 'sets string' do
        default_attributes[:store] = 'Pick n Pay'
        expect(subject.store).to eq('Pick n Pay')
      end

      it 'will not set to nil' do
        default_attributes[:store] = nil
        expect { subject }.to raise_error(TypeError, 'no implicit conversion of nil into String')
      end

      it 'will raise error if key missing' do
        default_attributes.delete(:store)
        expect { subject }.to raise_error(ArgumentError, 'missing keyword: store')
      end
    end

    describe 'region' do
      it 'sets string' do
        default_attributes[:region] = 'ZA-WC'
        expect(subject.region).to eq('ZA-WC')
      end

      it 'will not set to nil' do
        default_attributes[:region] = nil
        expect { subject }.to raise_error(TypeError, 'no implicit conversion of nil into String')
      end

      it 'will raise error if key missing' do
        default_attributes.delete(:region)
        expect { subject }.to raise_error(ArgumentError, 'missing keyword: region')
      end
    end

    describe 'location' do
      it 'sets string' do
        default_attributes[:location] = 'Cape Town'
        expect(subject.location).to eq('Cape Town')
      end

      it 'will not set to nil' do
        default_attributes[:location] = nil
        expect { subject }.to raise_error(TypeError, 'no implicit conversion of nil into String')
      end

      it 'will raise error if key missing' do
        default_attributes.delete(:location)
        expect { subject }.to raise_error(ArgumentError, 'missing keyword: location')
      end
    end

    describe 'product_brand_name' do
      it 'sets string' do
        default_attributes[:product_brand_name] = 'Fanta'
        expect(subject.product_brand_name).to eq('Fanta')
      end

      it 'will not set to nil' do
        default_attributes[:product_brand_name] = nil
        expect { subject }.to raise_error(TypeError, 'no implicit conversion of nil into String')
      end

      it 'will raise error if key missing' do
        default_attributes.delete(:product_brand_name)
      end
    end

    describe 'quantity' do
      it 'sets string' do
        default_attributes[:quantity] = '1'
        expect(subject.quantity).to eq(1)
      end

      it 'sets fixnum' do
        default_attributes[:quantity] = 2
        expect(subject.quantity).to eq(2)
      end

      it 'will not set invalid number string' do
        default_attributes[:quantity] = 'asd'
        expect { subject }.to raise_error(ArgumentError, 'invalid value for Integer(): "asd"')
      end

      it 'will set float string' do
        default_attributes[:quantity] = '1.5'
        expect { subject }.to raise_error(ArgumentError, 'invalid value for Integer(): "1.5"')
      end

      it 'will not set float' do
        default_attributes[:quantity] = 1.5
        expect { subject }.to raise_error(ArgumentError, 'invalid value for Integer(): "1.5"')
      end

      it 'will not set to nil' do
        default_attributes[:quantity] = nil
        expect { subject }.to raise_error(TypeError, 'no implicit conversion of nil into Integer')
      end

      it 'will raise error if key missing' do
        default_attributes.delete(:quantity)
        expect { subject }.to raise_error(ArgumentError, 'missing keyword: quantity')
      end
    end

    describe 'package_size' do
      it 'sets string' do
        default_attributes[:package_size] = '1'
        expect(subject.package_size).to eq(1.0)
      end

      it 'sets fixnum' do
        default_attributes[:package_size] = 2
        expect(subject.package_size).to eq(2.0)
      end

      it 'will not set invalid number string' do
        default_attributes[:package_size] = 'asd'
        expect { subject }.to raise_error(ArgumentError, 'invalid value for Float(): "asd"')
      end

      it 'will set float string' do
        default_attributes[:package_size] = '1.5'
        expect(subject.package_size).to eq(1.5)
      end

      it 'will set float' do
        default_attributes[:package_size] = 1.5
        expect(subject.package_size).to eq(1.5)
      end

      it 'will not set to nil' do
        default_attributes[:package_size] = nil
        expect { subject }.to raise_error(TypeError, 'can\'t convert nil into Float')
      end

      it 'will raise error if key missing' do
        default_attributes.delete(:package_size)
        expect { subject }.to raise_error(ArgumentError, 'missing keyword: package_size')
      end
    end

    describe 'package_unit' do
      it 'sets string' do
        default_attributes[:package_unit] = 'grams'
        expect(subject.package_unit).to eq('grams')
      end

      it 'will not set to nil' do
        default_attributes[:package_unit] = nil
        expect { subject }.to raise_error(TypeError, 'no implicit conversion of nil into String')
      end

      it 'will raise error if key missing' do
        default_attributes.delete(:package_unit)
        expect { subject }.to raise_error(ArgumentError, 'missing keyword: package_unit')
      end
    end

    describe 'total_price' do
      it 'sets string' do
        default_attributes[:total_price] = '1'
        expect(subject.total_price).to eq(1.0)
      end

      it 'sets fixnum' do
        default_attributes[:total_price] = 2
        expect(subject.total_price).to eq(2.0)
      end

      it 'will not set invalid number string' do
        default_attributes[:total_price] = 'asd'
        expect { subject }.to raise_error(ArgumentError, 'invalid value for Float(): "asd"')
      end

      it 'will set float string' do
        default_attributes[:total_price] = '1.5'
        expect(subject.total_price).to eq(1.5)
      end

      it 'will set float' do
        default_attributes[:total_price] = 1.5
        expect(subject.total_price).to eq(1.5)
      end

      it 'will not set to nil' do
        default_attributes[:total_price] = nil
        expect { subject }.to raise_error(TypeError, 'can\'t convert nil into Float')
      end

      it 'will raise error if key missing' do
        default_attributes.delete(:total_price)
        expect { subject }.to raise_error(ArgumentError, 'missing keyword: total_price')
      end
    end

    describe 'category' do
      it 'sets string' do
        default_attributes[:category] = 'Drinks'
        expect(subject.category).to eq('Drinks')
      end

      it 'will not set to nil' do
        default_attributes[:category] = nil
        expect { subject }.to raise_error(TypeError, 'no implicit conversion of nil into String')
      end

      it 'will raise error if key missing' do
        default_attributes.delete(:category)
        expect { subject }.to raise_error(ArgumentError, 'missing keyword: category')
      end
    end

    describe 'generic_name' do
      it 'sets string' do
        default_attributes[:generic_name] = 'Soda'
        expect(subject.generic_name).to eq('Soda')
      end

      it 'will not set to nil' do
        default_attributes[:generic_name] = nil
        expect { subject }.to raise_error(TypeError, 'no implicit conversion of nil into String')
      end

      it 'will raise error if key missing' do
        default_attributes.delete(:generic_name)
        expect { subject }.to raise_error(ArgumentError, 'missing keyword: generic_name')
      end
    end
  end

  describe 'price_per_package_unit' do
    it 'equals total_price(10)/package_size(1)/quantity(1)' do
      default_attributes[:total_price] = 10
      default_attributes[:package_size] = 1
      default_attributes[:quantity] = 1
      expect(subject.price_per_package_unit).to eq(10.0)
    end

    it 'equals total_price(10)/package_size(1)/quantity(2)' do
      default_attributes[:total_price] = 10
      default_attributes[:package_size] = 1
      default_attributes[:quantity] = 2
      expect(subject.price_per_package_unit).to eq(5.0)
    end

    it 'equals total_price(10)/package_size(2)/quantity(1)' do
      default_attributes[:total_price] = 10
      default_attributes[:package_size] = 2
      default_attributes[:quantity] = 1
      expect(subject.price_per_package_unit).to eq(5.0)
    end

    it 'equals total_price(100)/package_size(2)/quantity(2)' do
      default_attributes[:total_price] = 100
      default_attributes[:package_size] = 2
      default_attributes[:quantity] = 2
      expect(subject.price_per_package_unit).to eq(25.0)
    end
  end
end
