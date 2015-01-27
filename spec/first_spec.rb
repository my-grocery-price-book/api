ENV['RACK_ENV'] = 'test'

require './app/api'  # <-- your sinatra app
require 'bacon'
require 'rack/test'

describe 'The PriceBook App' do
  extend Rack::Test::Methods

  def app
    Rack::Builder.parse_file('./config.ru').first
  end

  it "says hello" do
    get '/v1'
    last_response.should.be.ok
    last_response.body.should.equal '"Hello World"'
  end
end
