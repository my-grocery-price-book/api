# config valid only for current version of Capistrano
lock '3.4.0'

# HACK: to allow set :tmp_dir, '~/tmp'
require 'net/scp'
module Net
  # reopening SCP class
  class SCP
    def upload!(local, remote, options = {}, &progress)
      remote = remote.gsub('~/', '') if remote.start_with?('~/')
      upload(local, remote, options, &progress).wait
    end
  end
end

set :application, 'grocery_price_book_api'
set :repo_url, 'git@bitbucket.org:grantspeelman/grocery_price_book_api.git'

set :ssh_options, forward_agent: true

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :rollbar_token, 'b330dae833714676a4e8c809b11144f6'
# set :rollbar_env, Proc.new { fetch :stage }
# set :rollbar_role, Proc.new { :app }

set :deploy_to, '~'
set :tmp_dir, '~/tmp'

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('.env.production')

# Default value for linked_dirs is []
set :linked_dirs,
    fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'db/sqlite3')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rack_env, 'production'

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
