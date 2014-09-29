#!/usr/bin/env bundle

source 'https://rubygems.org'

group :default do
  # === LocomotiveCMS ===

  gem 'locomotivecms_wagon', github: 'locomotivecms/wagon'
  # gem 'locomotivecms_wagon', path: '../../../sandbox/locomotivecms/wagon'

  gem 'locomotivecms_mounter', github: 'locomotivecms/mounter'
  # gem 'locomotivecms_mounter', path: '../../../sandbox/locomotivecms/gems/mounter'
end

group :misc do
  gem 'initializify', github: 'bitaculous/initializify'

  gem 'liquids', github: 'bitaculous/liquids'

  gem 'vendorify', github: 'bitaculous/vendorify'

  # === Assets ===

  gem 'assetify', github: 'bitaculous/assetify'

  # --- Cascading Style Sheets ----

  gem 'susy', '~> 2.1.3'

  # --- JavaScript ----

  gem 'hogan_assets', '~> 1.6.0'

  # === Templating ===

  gem 'kramdown', '~> 1.4.2'

  # === OS X ===

  gem 'rb-fsevent', '~> 0.9.4', require: RUBY_PLATFORM.include?('darwin') && 'rb-fsevent'
end