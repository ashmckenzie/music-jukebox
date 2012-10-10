class Playlist < Sequel::Model

  many_to_one :station
  one_to_many :playlists_tracks
  many_to_many :tracks, :join_table => :playlists_tracks

  def as_json full=false
    data = {
      :id => id,
      ':self' => BASE_URL + "/station/#{station.id}/playlist/#{id}",
      :name => name,
      :created_at => created_at,
      :updated_at => updated_at
    }
    data.merge!(station_as_json) if full
    data.merge!(playlist_tracks_as_json) if full
    data
  end

  def station_as_json
    { :station => station.as_json }
  end

  def playlist_tracks_as_json
    { :tracks => playlists_tracks_dataset.order(:last_played_at).all.map { |track| track.as_json }  }
  end
end
