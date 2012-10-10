require 'bundler/setup'
Bundler.require(:default, :development)

Dir['./config/initialisers/*.rb'].each { |f| require f }

get '/' do
  redirect to('/stations')
end

get '/stations' do
  content_type :json
  Station.all.map { |station| station.as_json }.to_json
end

get '/station/:id' do
  content_type :json
  Station[params[:id]].as_json(true).to_json
end

get '/track/:id' do
  content_type :json
  Track[params[:id]].as_json.to_json
end

get '/station/:id/playlists' do
  content_type :json
  station = Station[params[:id]]
  data = station.as_json
  data.merge!({ :playlists => station.playlists.map { |playlist| playlist.as_json } })
  data.to_json
end

get '/station/:station_id/playlist/:playlist_id' do
  content_type :json
  Playlist.where(:id => params[:playlist_id], :station_id => params[:station_id]).first.as_json(true).to_json
end

get '/station/:station_id/playlist/:playlist_id/playlist_track/:playlist_track_id' do
  content_type :json
  PlaylistsTrack[params[:playlist_track_id]].as_json(true).to_json
end
