require './app/api.rb'

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
