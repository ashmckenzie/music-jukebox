#!/usr/bin/env ruby

require 'bundler/setup'
Bundler.require(:default, :development)

require 'drb/drb'

Dir['./config/initialisers/*.rb'].each { |f| require f }

class Play
  def search query
    ::MusicJukebox::Spotify.search(query)
  end

  def play track_id
    track = Hallon::Track.new("spotify:track:#{track_id}").load
    player.play(track)
  end

  def stop
    player.stop
  end

  def player
    @player ||= Hallon::Player.new(Hallon::OpenAL)
  end
end

FRONT_OBJECT= Play.new
# $SAFE = 1

DRb.start_service("druby://localhost:8787", FRONT_OBJECT)
DRb.thread.join
