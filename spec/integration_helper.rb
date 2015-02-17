require 'spec_helper'
require 'rack/test'

require './app/models/price_entry/repo'

def app
  @app ||= Rack::Builder.parse_file('./config.ru').first
end

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:each, type: :integration) do
    PriceEntry::Repo.instance.reset
  end
end
