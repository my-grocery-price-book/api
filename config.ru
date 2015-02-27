require './app/api.rb'

require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', :headers => :any, :methods => [:get, :post, :options]
  end
end

use Rack::CommonLogger, LOGGER
run PriceBookApi
