require './app/api.rb'

require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :options]
  end
end

require 'newrelic_rpm'

require 'staccato/rack'
use Staccato::Rack::Middleware, ENV['GA_TRACKING_ID'], logger: LOGGER

use Rack::CommonLogger, LOGGER
run PriceBookApi.freeze.app
