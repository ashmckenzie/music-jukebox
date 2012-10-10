class Station < Sequel::Model

  one_to_many :playlists

  def as_json include_playlists=false
    data = {
      :id => id,
      ':self' => BASE_URL + "/station/#{id}",
      :name => name,
      :created_at => created_at,
      :updated_at => updated_at
    }
    data.merge!(playlists_as_json) if include_playlists
    data
  end

  def playlists_as_json
    {
      :playlists => playlists.map { |playlist| playlist.as_json(false) }
    }
  end
end
