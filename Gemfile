source 'https://rubygems.org'

# application
gem 'grape'
gem 'grape-swagger'
gem 'rack-cors', require: 'rack/cors'
gem 'rake'
gem 'sequel'
gem 'sqlite3'
gem 'syslogger'
gem 'newrelic_rpm' # application metrics
gem 'rollbar' # error tracking

group :production do
  gem 'puma'
end

group :development do
  gem 'shotgun'
  # deployment
  gem 'capistrano', '~> 3.3'
  gem 'capistrano3-puma'
  gem 'capistrano-bundler'
end

group :development, :test do
  gem 'rubocop'
  gem 'rspec'
  gem 'parallel_tests'
end

group :test do
  gem 'mutant-rspec'
  gem 'rack-test'
  gem 'simplecov'
end
