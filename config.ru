#!/usr/bin/env rackup

require 'rubygems'
require 'bundler/setup'

require 'locomotive/wagon/standalone_server'

run Locomotive::Wagon::StandaloneServer.new File.expand_path('.')