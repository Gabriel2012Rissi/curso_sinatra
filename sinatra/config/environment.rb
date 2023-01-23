require 'bundler'
require 'bundler/setup'
require 'jsonapi-serializers'
require 'require_all'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/namespace'
require 'warden'

Bundler.require :default, ENV["SINATRA_ENV"].to_sym

# Configure project structure.
# Root path.
APP_ROOT = File.expand_path('..', __dir__)
# Require all application files.
require_all "#{APP_ROOT}/app"
# Require all configuration files.
require_all "#{APP_ROOT}/config"
