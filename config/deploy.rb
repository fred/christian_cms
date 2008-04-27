#
# General configuration
#
set :application, "comunidad-catolica.com"
set :user, "brfsa"
set :domain, "brfsa@comunidad-catolica.com"
set :deploy_to, "/home/brfsa/rails/comunidad-catolica.com"
set :repository, "http://comunidad-catolica.svnrepository.com/svn/iglesia"


#
# Mongrel configuration
#
set :mongrel_log_file, "/home/brfsa/rails/comunidad-catolica.com/log/mongrel.log"
set :mongrel_pid_file, "/home/brfsa/rails/comunidad-catolica.com/log/mongrel.pid"
set :mongrel_port, 4010
set :mongrel_servers, 1
set :mongrel_clean, true
set :mongrel_environment, 'production'

#
# Customize Vlad to our needs
#
namespace :vlad do
  #
  # Add an after_update hook
  #
  remote_task :update do
    Rake::Task['vlad:after_update'].invoke
  end

  #
  # The after_update hook, which is run after vlad:update
  #
  remote_task :after_update do
  # Link to shared resources, if you have them in .gitignore
    run "ln -s #{deploy_to}/shared/config/database.yml #{deploy_to}/current/config/database.yml"
  end

  #
  # Deploys a new version of your application
  #
  remote_task :deploy => [:update, :migrate, :start_app]
end
