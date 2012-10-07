require 'bundler/setup'
Bundler.require(:default, :development)

require './spotify_app'
SpotifyApp.run!

