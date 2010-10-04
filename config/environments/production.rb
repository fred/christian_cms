# -*- encoding : utf-8 -*-
# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Comment this to Enable threaded mode
config.threadsafe!

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# Using file_Store for session store:
config.action_controller.session_store = :cookie_store
config.action_controller.session = {
  :key    => '_comunidad_catolica_production',
  :secret => '87bd2b6b27051bb2610a7dd5f643f077ef2b0ca9b32119645c0eb294810bea6e638ecd8f7f1f2277a7d3959f9f43c14ecb03f291b079050850553046b8e52adf'
}

# it’s a good idea to use Memcache also for session storage.
# require 'memcache'
# config.action_controller.session_store = :mem_cache_store
# memcache_options = {
#   :c_threshold => 10_000,
#   :compression => false,
#   :debug => false,
#   :namespace => "ului_#{RAILS_ENV}",
#   :readonly => false,
#   :urlencode => false
# }
# CACHE = MemCache.new(memcache_options)
# CACHE.servers = '127.0.0.1:11211'
# ActionController::Base.session_options[:expires] = 86400
# ActionController::Base.session_options[:cache] = CACHE
# config.action_controller.session = {
#   :session_key => '_comunidad_catolica_production',
#   :secret      => '91cf32a47f45f8a9a5ab0a5428bcc551a73b64ba340f67cb8a9dac6d8e02e3P7ec63r4L8x61b5C4x6df06X4W8c9cOe173a4975ca3',
#   :cache       => CACHE,
#   :expires => 86400
# }
