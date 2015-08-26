# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../config/enviroment')
require 'roda'

require './app/commands/price_entry'
require './app/commands/user'

# main grape class
class PriceBookApi < Roda
  plugin :error_handler do |error|
    response['Content-Type'] = 'application/json'
    if error.is_a?(User::ValidationError)
      LOGGER.warn(error)
      error(400, { error: error.message }.to_json)
    else
      LOGGER.error(error)
      Rollbar.error(error)
      error(500, { error: error.message }.to_json)
    end
  end
  plugin :sinatra_helpers
  plugin :all_verbs
  plugin :json, serializer: proc { |object| object.to_json }

  route do |request| # the request object
    response['Content-Type'] = 'application/json'

    request.get 'test_failure' do
      fail 'Test Failure'
    end

    request.get 'ping' do
      { pong: DB.get { version {} }.present? }
    end

    request.post 'users' do
      status 201
      User::AddCommand.new(email: request.params['email'],
                           shopper_name: request.params['shopper_name']).execute
    end

    request.on ':region' do |region|
      request.get 'store_names' do
        PriceEntry::StoreNamesQuery.new(region: region).execute
      end

      request.get 'location_names' do
        PriceEntry::LocationNamesQuery.new(region: region).execute
      end

      request.get 'product_brand_names' do
        PriceEntry::ProductBrandNamesQuery.new(region: region, search_text: request.params['term']).execute
      end

      request.get 'unit_names' do
        PriceEntry::UnitNamesQuery.new(region: region).execute
      end

      request.get 'product_generic_names' do
        PriceEntry::ProductGenericNamesQuery.new(region: region).execute
      end

      request.get 'products' do
        PriceEntry::ProductsQuery.new(region: region, term: request.params['term']).execute
      end

      request.on 'entries' do
        request.post do
          shopper_id = User::GetShopperIdForKey.new(api_key: request.params['api_key']).execute
          error(401, 'invalid api_key') if shopper_id.nil?
          PriceEntry::AddPriceCommand.new(
            generic_name: request.params['generic_name'], product_brand_name: request.params['product_brand_name'],
            date_on: request.params['date_on'], store: request.params['store'], location: request.params['location'],
            region: region, package_size: request.params['package_size'],
            package_unit: request.params['package_unit'], quantity: request.params['quantity'],
            total_price: request.params['total_price'], category: request.params['category'],
            expires_on: request.params['expires_on'], extra_info: request.params['extra_info'], shopper_id: shopper_id
          ).execute
          status 201
          { success: true }
        end

        request.get do
          PriceEntry::PricesQuery.new(region: region,
                                      limit: request.params['limit'],
                                      search_string: request.params['search']).execute
        end
      end
    end
  end
end
