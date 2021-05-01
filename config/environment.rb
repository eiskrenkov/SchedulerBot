require 'bundler/setup'

env = (ENV['RACK_ENV'] || 'development')
Bundler.require :default, env.to_sym
