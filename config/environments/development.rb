# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false


# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
config.action_controller.session = {
  :key    => '_comunidad_catolica_dev',
  :secret => '733ac61e32f9d9e6c3964877028b5b77cc84437fffadb95e048a96d1ed0df1380787cc349d7ee25fcf1490edf599f17d4b9bfd01c1a7611644d0e0588979c016'
}
