server '192.168.33.10', user: 'price_book_api', roles: %w(web app)

set :ssh_options,  forward_agent: true
