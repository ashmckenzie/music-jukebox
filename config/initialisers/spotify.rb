require 'json'

Dir['./lib/music_jukebox/*'].each { |file| require file }

Hallon::Track.class_eval {
  def as_json
    {
      :name => name,
      :link => to_link.to_str,
      :album => {
        :name => album.name,
        :image_url => album.cover_link.to_url
      },
      :artist => {
        :name => artist.name,
        :image_url => artist.portrait_link ? artist.portrait_link.to_url : ''
      }
    }
  end

  def as_str
    "#{name} - #{artist.name} (#{to_link.to_str})"
  end
}

MusicJukebox::Spotify.new.login
