#!/usr/bin/env bundle

source 'https://rubygems.org'

group :default do
  group :locomotivecms do
    gem 'locomotivecms_wagon',   github: 'locomotivecms/wagon'
    gem 'locomotivecms_mounter', github: 'locomotivecms/mounter'
  end

  group :templating do
    gem 'kramdown', '~> 1.3.2'
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
  end
end