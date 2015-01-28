# deploy within vagrant
server '127.0.0.1', user: 'price_book_api', roles: %w{web app}

set :ssh_options, {
   forward_agent: true
}
