ENV['RACK_ENV'] = 'test'

require './app/api'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

describe 'The PriceBook App' do
  before :all do
    @client = Elasticsearch::Client.new
    #    @client.indices.delete index: 'test' if @client.indices.exist? index: 'test'
  end

  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('./config.ru').first
  end

  it 'gets the auto generated docs' do
    get '/swagger_doc'
    expect(last_response.status).to eq(200)
  end

  it 'create new entry' do
    post '/entries', date_on: Date.today.to_s, store: 'Pick n Pay', location: 'Canal Walk', brand: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '13.99'
    expect(last_response.status).to eq(201)
    @client.indices.flush index: 'test'
    get '/entries'
    puts last_response.body
    expect(last_response.status).to eq(200)
  end
end
