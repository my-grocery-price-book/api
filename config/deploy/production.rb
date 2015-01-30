server '41.79.78.175', user: 'price_book_api', roles: %w{web app}

set :ssh_options, {
   forward_agent: true
}

set :rack_env, 'production'
