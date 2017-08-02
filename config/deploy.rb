# config valid only for current version of Capistrano
lock "3.9.0"

set :application, "catalogue-display"
set :scm, :git
set :repo_url, "https://github.com/pognut/catalogue-display.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/rails/catalogue-display"

# Default value for :format is :airbrussh.
set :format, :pretty

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# set :rvm1_map_bins, %w(rake gem bundle ruby honeybadger)
set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }
set :unicorn_config, "/etc/default/unicorn"
set :unicorn_pid, "/var/run/unicorn.pid"

# set :bundle_flags, '--deployment'

# set :bundle_path, -> { current_path }

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
      # Your restart mechanism here, for example:
      # invoke 'unicorn:reload'
    end





# #   after :restart, :clear_cache do
# #     on roles(:web), in: :groups, limit: 3, wait: 10 do
# #       # Here we can do anything such as:
# #       # within release_path do
# #       #   execute :rake, 'cache:clear'
# #       # end
# #     end
# #   end

end

after 'deploy', 'unicorn:restart'
