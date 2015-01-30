ENV['RACK_ENV'] = 'test'

require './app/api'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

describe 'The PriceBook App' do
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('./config.ru').first
  end

  it 'says hello' do
    get '/v1'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('"Hello World"')
  end
end
