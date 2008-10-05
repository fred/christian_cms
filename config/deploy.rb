set :application, "comunidad-catolica.com"

# Primary domain name of your application. Used as a default for all server roles.
set :domain, "209.20.76.20"

# Login user for ssh.
set :user, "fred"
set :use_sudo,  false

set :scm, "git"

# URL of your source repository.
set :repository,  "git://github.com/fred/christian_cms.git "
# for SVN
#set :repository, "svn+ssh://fred@comizu.com/var/svn/repos/iglesia/trunk"

# Set Branch
set :branch, "master"

# We need to turn on the :pty option because it would seem we don’t get the passphrase prompt from git if we don’t. 
# Point the :repository option to your github clone URL. 
# Set the :passphrase to the one you generated in the initial step, and set :user to the one you just created.
# If you’re using your own private keys for git you might want to tell Capistrano to use agent forwarding with this command
ssh_options[:forward_agent] = true
default_run_options[:pty] = true
ssh_options[:paranoid] = false 

# This will specify the branch that gets checked out for the deployment.
# Older versions of git (e.g. 1.4.4.2) don’t support -q on git checkout command. 
# This will cause your deployment to fail by default. To fix either upgrade git or do: set :scm_verbose, true 
# You may also wish to use one of the following options if your git repo is very large – 
#  otherwise each deploy will do a full repository clone every time. 
set :deploy_via, :remote_cache

# Rails environment. Used by application setup tasks and migrate tasks.
set :rails_env, "production"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"


role :web, domain
role :app, domain
role :db,  domain, :primary => true
role :scm, domain

task :after_symlink, :roles => :app do
  run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  run "ln -nfs #{shared_path}/assets/buletins #{current_path}/public/"
end

# following line added per latest railsmachine instructions
#set :runner, 'deploy'

namespace :passenger do 
  %w(start stop restart).each do |action| 
  desc "#{action} this app's Thin Server" 
    task action.to_sym, :roles => :app do 
      run "touch #{current_path}/tmp/restart.txt"
    end
  end
end 

namespace :deploy do 
  %w(start stop restart).each do |action| 
    desc "#{action} our server"
    task action.to_sym do 
      find_and_execute_task("passenger:#{action}")
    end
  end
end
