source 'https://rubygems.org'

# application
gem 'grape'
gem 'rack-cors', :require => 'rack/cors'
gem 'airbrake', '~> 3.1'
gem 'rake', require: false
gem 'rubocop'

# deployment
gem 'capistrano', require: false
gem 'capistrano-bundler', require: false

group :development do
  gem 'shotgun', require: false
end

group :test do
  gem 'bacon'
  gem 'rack-test', require: false
end
