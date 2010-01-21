set :application, "comunidad-catolica.com"

# Primary domain name of your application. Used as a default for all server roles.
set :domain, "comunidad-catolica.com"

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

# mongrel port
set :port, "3001"


#default_environment["PATH"] = "/opt/ree/bin:/opt/ree/lib/ruby/gems/1.8/bin:$PATH"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"


role :web, domain
role :app, domain
role :db,  domain, :primary => true
role :scm, domain


# following line added per latest railsmachine instructions
#set :runner, 'deploy'

namespace :sphinx do
  desc "Generate the ThinkingSphinx configuration file"
  task :configure do
    run "cd #{current_path} && rake thinking_sphinx:configure"
  end
  desc "Generate Sphinx Index"
  task :index do
    run "cd #{current_path} && rake thinking_sphinx:index"
  end
  desc "Stop Sphinx"
  task :stop do
    run "cd #{current_path} && rake thinking_sphinx:stop"
  end
  desc "Start Sphinx"
  task :start do
    run "cd #{current_path} && rake thinking_sphinx:start"
  end
  desc "Restart Sphinx"
  task :restart do
    run "cd #{current_path} && rake thinking_sphinx:restart"
  end
  desc "Configure, index and start sphinx"
  task :reload do
    configure
    index
    start
  end
end


namespace :passenger do 
  %w(start stop restart).each do |action| 
  desc "#{action} this app's passenger Server" 
    task action.to_sym, :roles => :app do 
      run "touch #{current_path}/tmp/restart.txt"
    end
  end
end


namespace :mongrel do
  desc "Stop this app's Mongrel Server" 
  task :stop, :roles => :app do 
    run "mongrel_rails -p #{shared_path}/pids/server.pid stop"
  end
  desc "Start this app's Mongrel Server" 
  task :start, :roles => :app do 
    run "ruby #{current_path}/script/server -p #{port} -e #{rails_env} -d start"
    #run "mongrel_rails start -P #{port} -e #{rails_env} -d"
  end
  desc "Restart this app's Mongrel Server" 
  task :restart, :roles => :app do 
    find_and_execute_task("mongrel:stop")
    find_and_execute_task("mongrel:start")
  end
end


namespace :thin do 
  desc "Stop this app's Thin Server" 
  task :stop, :roles => :app do 
    run "thin -C #{shared_path}/config/thin.yml stop"
  end
  desc "Start this app's Thin Server" 
  task :start, :roles => :app do 
    run "thin -C #{shared_path}/config/thin.yml start"
  end
  desc "Restart this app's Thin Server" 
  task :restart, :roles => :app do 
    find_and_execute_task("thin:stop")
    find_and_execute_task("thin:start")
  end
end

namespace :deploy do 
  %w(start stop restart).each do |action| 
    desc "#{action} our server"
    task action.to_sym do 
      find_and_execute_task("mongrel:#{action}")
    end
  end
end


task :after_symlink, :roles => :app do
  run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  run "ln -nfs #{shared_path}/assets/buletins #{current_path}/public/"
  run "mkdir -p #{current_path}/tmp/cache"
  run "mkdir -p #{current_path}/tmp/sessions"
end

