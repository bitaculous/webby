#!/usr/bin/env rackup

require 'rubygems'
require 'bundler/setup'

require 'locomotive/wagon/standalone_server'

path = File.expand_path '.'

run Locomotive::Wagon::StandaloneServer.new(path)