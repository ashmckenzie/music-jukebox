Sequel.migration do
  change do
    create_table :stations do
      primary_key :id
      String :name
      DateTime :created_at, :default => Time.now.utc
      DateTime :updated_at, :default => Time.now.utc
    end
  end
end
