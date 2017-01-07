set :ssh_options, {
  user: 'deploy',
  forward_agent: true
}

set :stage, :production
set :rails_env,   'production'
set :application, 'xo'
set :branch, "master"

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/home/deploy/#{fetch(:application)}"
