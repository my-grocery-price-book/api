require 'unit_helper'
require 'rack/test'

require './config/enviroment'
require './app/commands/price_entry'
require './app/commands/user'

def app
  @app ||= Rack::Builder.parse_file('./config.ru').first
end

def price_params(override_params = {})
  { api_key: default_api_key,
    store: 'Pick n Pay',
    location: 'Canal Walk',
    product_brand_name: 'Coke',
    category: 'Drinks',
    package_size: '340',
    date_on: Date.today.to_s,
    package_unit: 'ml',
    quantity: '6',
    total_price: '38.99' }.merge(override_params)
end

def default_api_key
  return @api_key if @api_key
  post '/users', email: 'grant@example.com'
  @api_key = JSON.parse(last_response.body)['api_key']
end

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:each, type: :integration) do
    DB[:price_entries].truncate
    DB[:users].truncate
  end
end
