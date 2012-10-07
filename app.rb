require 'json'
require 'uri'

class App < Sinatra::Base

  configure do
    set :port, 9999
  end

  get '/' do
    @tracks = []
    @query = params[:query]
    @current_track = current_track

    if @query
      @tracks = JSON.parse(search(@query)).map do |track|
        "#{track['name']} - #{track['artist']['name']} (#{track['link']})"
      end
    end

    erb :index
  end

  post '/play' do
    RestClient.post 'http://localhost:9998/play', :track_id => params[:track_id]
    redirect to('/')
  end

  post '/stop' do
    RestClient.post 'http://localhost:9998/stop', {}
    redirect to('/')
  end

  def search query
    RestClient.get "http://localhost:9998/search?query=#{URI.escape(query)}"
  end

  def current_track
    Hashie::Mash.new JSON.parse(RestClient.get('http://localhost:9998/current-track'))
  end
end
