require 'singleton'

module PriceEntry
  class Repo
    include Singleton

    def create(price_entry_object)
      result = elasticsearch_client.index index: "price_api_#{ENV['RACK_ENV'] }", body: price_entry_object.to_hash, type: 'price_entry'
      result['_id']
    end

    def find_by_id(id)
      result = elasticsearch_client.get(index: "price_api_#{ENV['RACK_ENV'] }", type: 'price_entry', id: id)
      PriceEntry::Item.new(generic_name: result['_source']['generic_name'],
                           date_on: Date.parse(result['_source']['date_on']),
                           store: result['_source']['store'],
                           location: result['_source']['location'],
                           brand: result['_source']['brand'],
                           quanity: result['_source']['quanity'],
                           quanity_unit: result['_source']['quanity_unit'],
                           total_price: result['_source']['total_price'],
                           expires_on: Date.parse(result['_source']['expires_on']),
                           extra_info: result['_source']['extra_info'])
    end

    private

    def elasticsearch_client
      @elasticsearch_client ||= Elasticsearch::Client.new
    end
  end
end
