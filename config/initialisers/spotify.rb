require 'json'

Dir['./lib/music_jukebox/*'].each { |file| require file }

Hallon::Track.class_eval {
  def as_json
    {
      :name => name,
      :link => to_link.to_str,
      :artist => {
        :name => artist.name
      }
    }
  end

  def as_str
    "#{name} - #{artist.name} (#{to_link.to_str})"
  end
}

MusicJukebox::Spotify.new.login
