#!/usr/bin/env bundle

source 'https://rubygems.org'

group :default do
  group :locomotivecms do
    # gem 'locomotivecms_wagon', github: 'locomotivecms/wagon'
    gem 'locomotivecms_wagon', path: '../locomotivecms/wagon'

    # gem 'locomotivecms_mounter', github: 'locomotivecms/mounter'
    gem 'locomotivecms_mounter', path: '../locomotivecms/gems/mounter'
  end

  # gem 'i18n', '0.6.9'
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
      gem 'bourbon', '~> 4.0.2'

      gem 'breakpoint', '~> 2.4.2'

      # gem 'compass', '~> 1.0.0.alpha.20'
      gem 'compass', github: 'compass/compass', branch: 'master'

      gem 'modular-scale', '~> 2.0.5'

      gem 'sassy-maps', '~> 0.4.0'

      gem 'susy', '~> 2.1.2'
    end
  end

  group :templating do
    gem 'kramdown', '~> 1.4'
  end

  gem 'initializify', github: 'bitaculous/initializify'

  gem 'liquids', github: 'bitaculous/liquids'

  gem 'vendorify', github: 'bitaculous/vendorify'
end