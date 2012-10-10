class PlaylistsTrack < Sequel::Model

  many_to_one :playlist
  many_to_one :track

  def as_json full=false
    data = {
      :id => id,
      ':self' => BASE_URL + "/station/#{playlist.station.id}/playlist/#{playlist.id}/playlist_track/#{id}",
    }

    if full
      data.merge!({
        :station => playlist.station.as_json,
        :playlist => playlist.as_json
      })
    end

    data.merge!({
      :track => track.as_json,
      :play_count => play_count,
      :rating => rating,
      :created_at => created_at,
      :updated_at => updated_at
    })
    data
  end
end
