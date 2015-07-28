require 'unit_helper'

require './app/commands/price_entry/add_price_command'

# test helpers for creating price entries
module AddPriceCommandHelpers
  def default_price_params(override_params = {})
    { store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke', category: 'Drinks',
      generic_name: 'Soda', package_size: 340, date_on: Date.today, package_unit: 'ml',
      quantity: 6.0, total_price: 38.99, expires_on: nil, extra_info: nil }.merge(override_params)
  end

  def create_price_entry(override_params = {})
    PriceEntry::AddPriceCommand.new(default_price_params(override_params)).execute
  end

  def truncate_price_entries
    DB[:price_entries].truncate
  end
end
