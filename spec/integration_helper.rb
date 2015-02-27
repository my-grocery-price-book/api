require 'spec_helper'
require 'rack/test'

require './config/enviroment'
require './app/models/price_entry'

def app
  @app ||= Rack::Builder.parse_file('./config.ru').first
end

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:each, type: :integration) do
    DB[:price_entries].truncate
  end
end
