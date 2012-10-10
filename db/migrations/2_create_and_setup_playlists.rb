Sequel.migration do
  change do
    create_table :playlists do
      primary_key :id
      String :name
      Number :station_id
      DateTime :created_at, :default => Time.now.utc
      DateTime :updated_at, :default => Time.now.utc
    end
  end
end
