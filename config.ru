require './app/api.rb'

require 'rollbar'
Rollbar.configure do |config|
  config.access_token = 'b330dae833714676a4e8c809b11144f6'
  # other configuration settings
  # ...
end

require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', :headers => :any, :methods => [:get, :post, :options]
  end
end

require 'newrelic_rpm'

use Rack::CommonLogger, LOGGER
run PriceBookApi
