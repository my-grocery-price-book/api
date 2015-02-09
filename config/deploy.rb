# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'grocery_price_book_api'
set :repo_url, 'git@bitbucket.org:grantspeelman/grocery_price_book_api.git'

# config/deploy.rb
set :rbenv_type, :system # or :system, depends on your rbenv setup
set :rbenv_ruby, 'jruby-9.0.0.0-pre1'

set :rbenv_prefix,
    "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby)
set :rbenv_roles, :all # default value

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :deploy_to, '/home/price_book_api'

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :puma_bind, 'tcp://0.0.0.0:9393'

namespace :deploy do
  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end
end
