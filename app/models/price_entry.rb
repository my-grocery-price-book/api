require 'date'

# price entry class
class PriceEntry
  attr_reader :date_on, :store, :location, :region, :product_brand_name, :quantity
  attr_reader :package_size, :package_unit, :total_price, :category, :generic_name

  def initialize(date_on:, store:, location:, region:, product_brand_name:, quantity:,
                 package_size:, package_unit:, total_price:, category:, generic_name:)
    @date_on = parse_date(date_on)
    @store = String.new(store)
    @location = String.new(location)
    @region = String.new(region)
    @product_brand_name = String.new(product_brand_name)
    @quantity = parse_quantity(quantity)
    @package_size = Float(package_size)
    @package_unit = String.new(package_unit)
    @total_price = Float(total_price)
    @category = String.new(category)
    @generic_name = String.new(generic_name)
  end

  private

  def parse_date(date)
    return date if date.instance_of?(Date)
    Date.parse(date)
  end

  def parse_quantity(quantity)
    fail TypeError, 'no implicit conversion of nil into Integer' if quantity.nil?
    Integer(quantity.to_s)
  end

  public

  def price_per_package_unit
    total_price / (package_size * quantity)
  end
end
