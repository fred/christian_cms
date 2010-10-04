# -*- encoding : utf-8 -*-
# require "#{RAILS_ROOT}/lib/localization.rb"
# Localization.lang = 'es_ES'
# Localization.load

# in config/initializer/locale.rb
# tell the I18n library where to find your translations
I18n.load_path += Dir[ File.join(RAILS_ROOT, 'lib', 'locale', '*.{rb,yml}') ]

# you can omit this if you're happy with English as a default locale
I18n.default_locale = :es
