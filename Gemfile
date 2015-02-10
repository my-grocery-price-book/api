source 'https://rubygems.org'

# application
gem 'grape'
gem 'grape-swagger'
gem 'rack-cors', require: 'rack/cors'
gem 'airbrake', '~> 3.1'
gem 'rake'
gem 'daybreak'

group :production do
  gem 'puma'
end

group :development do
  gem 'shotgun'
  # deployment
  gem 'capistrano', '~> 3.3'
  gem 'capistrano3-puma'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
end

group :development, :test do
  gem 'rubocop'
  gem 'rspec'
end

group :test do
  gem 'rack-test'
end
