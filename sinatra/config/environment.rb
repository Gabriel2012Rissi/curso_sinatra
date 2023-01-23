require 'bundler'
require 'bundler/setup'
require 'jsonapi-serializers'
require 'jwt'
require 'require_all'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/namespace'
require 'warden'

# Default environment configuration for the application.
Bundler.require :default, ENV["SINATRA_ENV"].to_sym || 'development'

# API Key for JWT.
# Note: This API_KEY is for development purposes only. Set the API_KEY environment 
# variable in production.
API_KEY = ENV['API_KEY'] || 'ZmvhBBpb4RlbyblpKoj9F716CoONTOtr'

# Configure project structure.
# Root path.
APP_ROOT = File.expand_path('..', __dir__)
# Require all application files.
require_all "#{APP_ROOT}/app"
# Require all configuration files.
require_all "#{APP_ROOT}/config"
