ENV['RACK_ENV'] = 'test'

require './app/api'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

describe 'The PriceBook App' do
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('./config.ru').first
  end

  it 'create new entry' do
    post '/v1/entries'
    expect(last_response.status).to eq(201)
  end
end
