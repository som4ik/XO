# config valid only for current version of Capistrano
lock "3.7.1"


set :application, 'XO'
set :repo_url, 'git@github.com:som4ik/XO.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

role :app, %w{139.59.14.152}
role :web, %w{139.59.14.152}
role :db,  %w{139.59.14.152}
# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'
set :scm, :git

set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '2.3.1'      # Defaults to: 'default'
set :rvm_custom_path, '~/.rvm'  # only needed if not detected

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info


set :deploy_via, :remote_cache
set :ssh_options, { forward_agent: true }
set :use_sudo, false
set :default_stage, 'production'

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w[config/database.yml config/secrets.yml]

# Default value for linked_dirs is []
set :linked_dirs, %w{log pids tmp/cache sockets vendor/bundle public/system public/uploads public/ckeditor_assets public/sitemap.xml.gz node_modules}

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :unicorn_pid, -> { File.join(shared_path, 'pids', 'unicorn.pid') }

namespace :deploy do

  task :start do
    invoke 'deploy:set_rails_env'
    invoke 'unicorn:start'
  end

  task :stop do
    invoke 'unicorn:stop'
  end

  task :restart do
    invoke 'unicorn:restart'
  end

  task :force_restart do
    invoke 'deploy:stop'
    invoke 'deploy:start'
  end

  after 'deploy:publishing', 'deploy:restart'
  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

end
