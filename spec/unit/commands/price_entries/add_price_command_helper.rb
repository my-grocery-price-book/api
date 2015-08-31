require 'unit_helper'

require './app/commands/price_entries/add_price_command'
require './app/models/price_entry'

# test helpers for creating price entries
module AddPriceCommandHelpers
  def default_price_params(override_params = {})
    { store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke', category: 'Drinks',
      generic_name: 'Soda', package_size: 340, date_on: Date.today, package_unit: 'ml',
      quantity: 6, total_price: 38.99, region: 'za-wc' }
      .merge(override_params)
  end

  def create_price_entry(override_params = {})
    p = default_price_params(override_params)
    PriceEntries::AddPriceCommand.new(price_entry_params: p, price_entries: DB[:price_entries]).execute
  end

  def truncate_price_entries
    DB[:price_entries].truncate
  end
end
