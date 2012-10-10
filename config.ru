require 'bundler/setup'
Bundler.require(:default, :development)

require 'sinatra'

require './app'
run Sinatra::Application

