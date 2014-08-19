#!/usr/bin/env bundle

source 'https://rubygems.org'

group :default do
  group :locomotivecms do
    # gem 'locomotivecms_wagon', github: 'locomotivecms/wagon'
    gem 'locomotivecms_wagon', path: '../locomotivecms/wagon'

    # gem 'locomotivecms_mounter', github: 'locomotivecms/mounter'
    gem 'locomotivecms_mounter', path: '../locomotivecms/gems/mounter'
  end
end

group :development do
  group :osx do
    gem 'rb-fsevent', '~> 0.9.4', require: RUBY_PLATFORM.include?('darwin') && 'rb-fsevent'
  end
end

group :misc do
  group :assets do
    gem 'assetify', github: 'bitaculous/assetify'

    group :stylesheets do
      gem 'breakpoint', '~> 2.5.0'

      gem 'compass', '~> 1.0.0'
      # gem 'compass', github: 'compass/compass', branch: 'stable'

      gem 'modular-scale', '~> 2.0.5'

      gem 'sassy-maps', '~> 0.4.0'

      gem 'susy', '~> 2.1.3'
    end

    group :javascripts do
      gem 'hogan_assets', '~> 1.6.0'
    end
  end

  group :templating do
    gem 'kramdown', '~> 1.4.1'
  end

  gem 'initializify', github: 'bitaculous/initializify'

  gem 'liquids', github: 'bitaculous/liquids'

  gem 'vendorify', github: 'bitaculous/vendorify'
end