Sequel.migration do
  change do
    create_table :playlists_tracks do
      primary_key :id
      foreign_key :playlist_id, :playlists
      foreign_key :track_id, :tracks
      Number :play_count, :default => 0
      Number :rating, :default => 0
      DateTime :last_played_at, :null => true
      DateTime :created_at, :default => Time.now.utc
      DateTime :updated_at, :default => Time.now.utc
      index :last_played_at
      index :play_count
      index :rating
    end
  end
end
