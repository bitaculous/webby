#!/usr/bin/env bundle

source 'https://rubygems.org'

group :default do
  group :locomotivecms do
    # gem 'locomotivecms_wagon', github: 'locomotivecms/wagon'
    gem 'locomotivecms_wagon', path: '../locomotivecms/wagon'

    # gem 'locomotivecms_mounter', github: 'locomotivecms/mounter'
    gem 'locomotivecms_mounter', path: '../locomotivecms/gems/mounter'
  end

  group :templating do
    gem 'kramdown', '~> 1.3.3'
  end
end

group :development do
  group :osx do
    gem 'rb-fsevent', '~> 0.9.4', require: RUBY_PLATFORM.include?('darwin') && 'rb-fsevent'
  end
end

group :misc do
  group :assets do
    # gem 'assetify', github: 'bitaculous/assetify'
    gem 'assetify', path: '../gems/assetify'

    group :stylesheets do
      gem 'bourbon', '~> 4.0.2'

      gem 'compass', github: 'compass/compass', branch: 'master'

      gem 'susy', '~> 2.1.2'
    end
  end

  # gem 'liquids', github: 'bitaculous/liquids'
  gem 'liquids', path: '../gems/liquids'

  # gem 'vendorify', github: 'bitaculous/vendorify'
  gem 'vendorify', path: '../gems/vendorify'
end