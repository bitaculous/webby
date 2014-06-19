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
    gem 'kramdown', '~> 1.4'
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
      gem 'bourbon', github: 'bitaculous/bourbon', branch: 'sass_path'

      gem 'compass', github: 'compass/compass', branch: 'master'

      gem 'susy', '~> 2.1.2'
    end
  end

  gem 'liquids', github: 'bitaculous/liquids'

  gem 'vendorify', github: 'bitaculous/vendorify'
end