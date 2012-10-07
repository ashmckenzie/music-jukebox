Dir['./config/initialisers/*.rb'].each { |f| require f }

$current_track = nil

class SpotifyApp < Sinatra::Base

  configure do
    set :port, 9998
  end

  get '/search' do
    content_type :json
    @query = params[:query]
    @tracks = MusicJukebox::Spotify.search(@query).collect do |track|
      track.as_json
    end.to_json
  end

  get '/current-track' do
    content_type :json
    ($current_track ? $current_track.as_json : {}).to_json
  end

  post '/stop' do
    MusicJukebox::Spotify.stop
    $current_track = nil
    nil
  end

  post '/play' do
    $current_track = MusicJukebox::Spotify.play(params[:track_id])
    nil
  end
end

