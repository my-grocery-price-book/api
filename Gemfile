source 'https://rubygems.org'

# application
gem 'grape'
gem 'rack-cors', require: 'rack/cors'
gem 'airbrake', '~> 3.1'
gem 'rake'

group :production do
  gem 'puma'
end

group :development do
  gem 'shotgun'
  # deployment
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-bundler'
end

group :development, :test do
  gem 'rubocop'
  gem 'rspec'
end

group :test do
  gem 'rack-test'
end
