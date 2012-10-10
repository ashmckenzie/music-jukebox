require 'bundler/setup'
Bundler.require(:default, :development)

Dir['./config/initialisers/*.rb'].each { |f| require f }

desc 'Console'
task :console do
  pry
end

namespace :db do

  task :migrate do
    puts `sequel -E -m db/migrations sqlite://db/database.db`
  end

  task :seed do
    station = Station.create(:name => 'Hooroo')

    playlists = [
      Playlist.create(:name => 'Default', :station_id => Station.where(:name => 'Hooroo').first.id),
      Playlist.create(:name => 'Chilled', :station_id => Station.where(:name => 'Hooroo').first.id)
    ]

    ONE_DAY = (60 * 60) * 24

    tracks = [
      Track.create(:name => 'Under the bridge', :external_id => 1),
      Track.create(:name => 'Eye of the tiger', :external_id => 2),
      Track.create(:name => 'Like a prayer', :external_id => 3),
      Track.create(:name => 'Burn it down', :external_id => 4)
    ]

    PlaylistsTrack.create(:playlist_id => playlists[0].id, :track_id => tracks[0].id, :last_played_at => nil)
    PlaylistsTrack.create(:playlist_id => playlists[0].id, :track_id => tracks[1].id, :last_played_at => Time.now.utc - ONE_DAY * 3, :rating => 2)
    PlaylistsTrack.create(:playlist_id => playlists[0].id, :track_id => tracks[2].id, :last_played_at => Time.now.utc - ONE_DAY * 6, :rating => -2)
    PlaylistsTrack.create(:playlist_id => playlists[0].id, :track_id => tracks[3].id, :last_played_at => nil)
  end
end
