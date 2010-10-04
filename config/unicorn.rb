# -*- encoding : utf-8 -*-
# 
# Sample verbose configuration file for Unicorn (not Rack)
#
# This configuration file documents many features of Unicorn
# that may not be needed for some applications. See
# http://unicorn.bogomips.org/examples/unicorn.conf.minimal.rb
# for a much simpler configuration file.
#
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.

# Use at least one worker per core if you're on a dedicated server,
# more will usually help for _short_ waits on databases/caches.
worker_processes 1

# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
working_directory "/var/www/apps/comunidad-catolica.com/current" # available in 0.94.0+

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen "/var/www/apps/comunidad-catolica.com/shared/pids/unicorn.sock", :backlog => 64
# listen 8080, :tcp_nopush => true

# nuke workers after 180 seconds instead of 60 seconds (the default)
# Need more time to process the feeds, at least 2-3 minutes
timeout 180

# feel free to point this anywhere accessible on the filesystem
pid "/var/www/apps/comunidad-catolica.com/shared/pids/unicorn.pid"

# By default, the Unicorn logger will write to stderr.
# Additionally, ome applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path "/var/www/apps/comunidad-catolica.com/shared/log/unicorn.stderr.log"
stdout_path "/var/www/apps/comunidad-catolica.com/shared/log/unicorn.stdout.log"

# combine REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  # The following is only recommended for memory/DB-constrained
  # installations.  It is not needed if your system can house
  # twice as many worker_processes as you have configured.
  #
  # # This allows a new master process to incrementally
  # # phase out the old master process with SIGTTOU to avoid a
  # # thundering herd (especially in the "preload_app false" case)
  # # when doing a transparent upgrade.  The last worker spawned
  # # will then kill off the old master process with a SIGQUIT.
  # old_pid = "#{server.config[:pid]}.oldbin"
  # if old_pid != server.pid
  #   begin
  #     sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
  #     Process.kill(sig, File.read(old_pid).to_i)
  #   rescue Errno::ENOENT, Errno::ESRCH
  #   end
  # end
  #
  # # *optionally* throttle the master from forking too quickly by sleeping
  sleep 1
end

after_fork do |server, worker|
  # per-process listener ports for debugging/admin/migrations
  # addr = "127.0.0.1:#{9293 + worker.nr}"
  # server.listen(addr, :tries => -1, :delay => 5, :tcp_nopush => true)

  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

  # if preload_app is true, then you may also want to check and
  # restart any other shared sockets/descriptors such as Memcached,
  # and Redis.  TokyoCabinet file handles are safe to reuse
  # between any number of forked children (assuming your kernel
  # correctly implements pread()/pwrite() system calls)
end


# READ: http://codelevy.com/2010/02/09/getting-started-with-unicorn 
