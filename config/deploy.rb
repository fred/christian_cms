set :application, "comunidad-catolica.com"

# Primary domain name of your application. Used as a default for all server roles.
set :domain, "209.20.76.20"

# Login user for ssh.
set :user, "fred"
set :use_sudo,  false

# URL of your source repository.
set :repository, "svn+ssh://fred@comizu.com/var/svn/repos/iglesia/trunk"

# Rails environment. Used by application setup tasks and migrate tasks.
set :rails_env, "production"

default_run_options[:pty] = true
ssh_options[:paranoid] = false 


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:

set :scm, :subversion

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
