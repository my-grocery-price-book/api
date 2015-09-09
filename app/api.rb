# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../config/enviroment')
require 'roda'

require_relative 'commands/price_entries'
require_relative 'commands/users'
require_relative 'models/price_entry'

# main grape class
class PriceBookApi < Roda
  plugin :error_handler do |error|
    response['Content-Type'] = 'application/json'
    if error.is_a?(Users::ValidationError)
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
      { pong: !DB.get { version {} }.nil? }
    end

    request.post 'users' do
      status 201
      Users::AddCommand.new(email: request.params['email'],
                            shopper_name: request.params['shopper_name']).execute
    end

    request.on ':region' do |region|
      request.get 'store_names' do
        PriceEntries::StoreNamesQuery.new(region: region).execute
      end

      request.get 'location_names' do
        PriceEntries::LocationNamesQuery.new(region: region).execute
      end

      request.get 'product_brand_names' do
        PriceEntries::ProductBrandNamesQuery.new(region: region, search_text: request.params['term']).execute
      end

      request.get 'unit_names' do
        PriceEntries::UnitNamesQuery.new(region: region).execute
      end

      request.get 'product_generic_names' do
        PriceEntries::ProductGenericNamesQuery.new(region: region).execute
      end

      request.get 'products' do
        PriceEntries::ProductsQuery.new(region: region, term: request.params['term']).execute
      end

      request.on 'entries' do
        request.post do
          shopper_id = Users::GetShopperIdForKey.new(api_key: request.params['api_key']).execute
          error(401, 'invalid api_key') if shopper_id.nil?
          PriceEntries::AddPriceCommand.new(
            price_entry_params: request.params.merge('region' => region),
            price_entries: DB[:price_entries]
          ).execute
          status 201
          { success: true }
        end

        request.get do
          PriceEntries::PricesQuery.new(region: region,
                                        limit: request.params['limit'],
                                        search_string: request.params['search'],
                                        product_brand_names: request.params['product_brand_names']).execute
        end
      end
    end
  end
end
