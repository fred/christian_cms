# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # You have to specify the <tt>:lib</tt> option for libraries, where the Gem name (<em>sqlite3-ruby</em>) differs from the file itself (_sqlite3_)
  config.gem 'will_paginate'
  config.gem 'mini_magick'
  config.gem 'RedCloth'
  config.gem 'json'
  config.gem 'feedtools', :lib => 'feed_tools'
  config.gem "calendar_date_select"
  config.gem 'haml'
  config.gem "factory_girl"
  config.gem "ajaxful_rating"
  config.gem 'rakismet', :version => "0.3.6"
  
  # These cause problems with irb. Left in for reference
  # config.gem 'rspec-rails', :lib => 'spec/rails', :version => '1.1.11'
  # config.gem 'rspec', :lib => 'spec', :version => '1.1.11'
  
  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  #config.time_zone = 'UTC'
  config.time_zone = "Bangkok"

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  # config.action_controller.session = {
  #   :session_key => '_iglesia',
  #   :secret      => 'db224d455171dcba55518e74af43366e52e3f239773f90aed0ab6caf6554f051504ce7232599d066150dbabff0f1654'
  # }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  #config.action_controller.session_store = :active_record_store
  
  # Use a different cache store in production
  config.cache_store = :file_store, "#{RAILS_ROOT}/tmp/cache/"

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # Please note that observers generated using script/generate observer need to have an _observer suffix
  # config.active_record.observers = :user_observer
  
  # The internationalization framework can be changed 
  # to have another default locale (standard is :en) or more load paths. 
  # All files from config/locales/*.rb,yml are added automatically. 
  # config.i18n.load_path << Dir[File.join(RAILS_ROOT, 'my', 'locales', '*.{rb,yml}')] 
  config.i18n.default_locale = :es
  
end


# defaults to exception.notifier@default.com
#. ExceptionNotifier.sender_address =  %("Application Error" <root@cppthss.info>)
# Recipients
#. ExceptionNotifier.exception_recipients = %w(fred.the.master@gmail.com)
# defaults to "[ERROR] "
#. ExceptionNotifier.email_prefix = "[ CPP #{RAILS_ROOT} ERROR ] "
# More Information at:
# http://code.google.com/p/super-exception-notifier/


 
# Domain Name:  comunidad-catolica.com
# This is a global key. It will work across all domains.
# 
# Public Key: 6LddpwoAAAAAABd3bZ3gFywQUhpk673vMq6wq6XL
# Use this in the JavaScript code that is served to your users
# 
# Private Key:  6LddpwoAAAAAAOE45l-NXTqIJcpBPdH8VRRwa3D1
# Use this when communicating between your server and our server. 
# Because this key is a global key, it is OK if the private key is distributed to multiple users.

# ENV['RECAPTCHA_PUBLIC_KEY'] = '6LddpwoAAAAAABd3bZ3gFywQUhpk673vMq6wq6XL'
# ENV['RECAPTCHA_PRIVATE_KEY'] = '6LddpwoAAAAAAOE45l-NXTqIJcpBPdH8VRRwa3D1'
