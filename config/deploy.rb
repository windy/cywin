require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'yaml'
require 'mina_sidekiq/tasks'

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)
#
def load_config(server)
  thirdpillar_config =YAML.load(File.open('config/mina.yml'))
  puts "———-> configuring #{server} server"
  set :domain, thirdpillar_config[server]['domain'] #retriving the domain value for current server
  set :deploy_to, thirdpillar_config[server]['deploy_to'] #retriving the deploy_to value for current server
  set :repository, thirdpillar_config[server]['repository']
  set :branch, thirdpillar_config[server]['branch']
end

server =  ENV['MINA_ENV']  || 'staging'
puts "deploying with ENV: #{server}"
load_config(server)
set :app_path, "#{deploy_to}/#{current_path}"

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'config/application.yml', 'config/service.yml', 'config/sunspot.yml', 'log', 'tmp', 'public/uploads']

set :user, 'ruby'    # Username in the server to SSH to.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  queue! %[source /usr/local/rvm/scripts/rvm]
  queue! %[rvm use 2.0.0]
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/pids/"]
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/public/uploads"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public/uploads"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      invoke :'unicorn:restart'
      invoke :'sidekiq:restart'
    end
  end
end

namespace :unicorn do
  set :unicorn_pid, "#{app_path}/tmp/pids/unicorn_cywin.pid"
  set :start_unicorn, %{
    cd #{app_path} && bundle exec unicorn -c config/unicorn/#{server}.rb -E #{rails_env} -D
  }

  desc "Start unicorn"
  task :start => :environment do
    queue 'echo "-----> Start Unicorn"'
    queue! start_unicorn
  end

  desc "Stop unicorn"
  task :stop do
    queue 'echo "-----> Stop Unicorn"'
    queue! %{
      mkdir -p "#{app_path}/tmp/pids"
      test -s "#{unicorn_pid}" && kill -QUIT `cat "#{unicorn_pid}"` && rm -rf "#{unicorn_pid}" && echo "Stop Ok" && exit 0
      echo >&2 "Not running"
    }
  end

  desc "Restart unicorn using 'upgrade'"
  task :restart => :environment do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end
