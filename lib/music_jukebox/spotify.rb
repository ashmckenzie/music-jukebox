$stdout.sync = true

require 'hallon'
require 'hallon-openal'

module MusicJukebox
  class Spotify

    attr_accessor :session

    def self.search query, limit=10
      search = Hallon::Search.new(query)
      search.load

      search.tracks[0...limit].map(&:load)
    rescue => e
      ap e
    end

    def self.play track_id
      stop
      track = Hallon::Track.new("spotify:track:#{track_id}")
      track.load
      player.play(track)
      track
    rescue => e
      ap e
    end

    def self.stop
      player.stop
      @player = nil
      GC.start
    rescue => e
      ap e
    end

    def self.player
      @player = Hallon::Player.new(Hallon::OpenAL)
    rescue => e
      ap e
      self.player
    end

    def app_key
      @app_key ||= IO.read(File.expand_path('../../../config/spotify_appkey.key', __FILE__))
    end

    def credentials
      @credentials ||= Hashie::Mash.new YAML.load_file('./config/credentials.yml')
    end

    def login
      @session = Hallon::Session.initialize(app_key) do
        on(:log_message) do |message|
          puts "[LOG] #{message}"
        end

        on(:credentials_blob_updated) do |blob|
          puts "[BLOB] #{blob}"
        end

        on(:connection_error) do |error|
          Hallon::Error.maybe_raise(error)
        end

        on(:logged_out) do
          abort "[FAIL] Logged out!"
        end
      end

      @session.login!(credentials.username, credentials.password, true)
    end
  end
end
