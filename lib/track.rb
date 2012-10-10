class Track < Sequel::Model

  def self.not_played
    where(:last_played_at => nil)
  end

  def as_json
    {
      :id => id,
      ':self' => BASE_URL + "/track/#{id}",
      :name => name,
      :external_id => external_id,
      :created_at => created_at,
      :updated_at => updated_at
    }
  end
end
