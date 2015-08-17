source 'https://rubygems.org'
ruby ENV['RUBY_VERSION'] if ENV['RUBY_VERSION']

# application
gem 'grape'
gem 'rack-cors', require: 'rack/cors'
gem 'rake'
gem 'sequel'
gem 'dotenv'
gem 'pg'
gem 'newrelic_rpm' # application metrics
gem 'staccato-rack' # google analytic tracking
gem 'rollbar' # error tracking
gem 'activesupport'

group :production do
  gem 'puma'
end

group :development do
  gem 'shotgun'
end

group :development, :test do
  gem 'rspec'
  gem 'parallel_tests'
end

group :test do
  gem 'sqlite3'
  gem 'mutant-rspec'
  gem 'rack-test'
  gem 'simplecov'
end
