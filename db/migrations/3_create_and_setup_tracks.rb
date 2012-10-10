Sequel.migration do
  change do
    create_table :tracks do
      primary_key :id
      String :name
      Number :external_id
      DateTime :created_at, :default => Time.now.utc
      DateTime :updated_at, :default => Time.now.utc
    end
  end
end
