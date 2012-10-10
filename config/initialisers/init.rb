require 'json'
require 'uri'
require "sequel"

BASE_URL = 'http://localhost:9999'

DB = Sequel.sqlite('./db/database.db')

Dir['./lib/*.rb'].each { |file| require file }
