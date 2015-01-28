server '41.79.78.174', user: 'price_book_api', roles: %w{web app}

set :ssh_options, {
   forward_agent: true
}
