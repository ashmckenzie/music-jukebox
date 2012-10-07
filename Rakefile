require 'bundler/setup'
Bundler.require(:default, :development)

desc 'Spotify console'
task :console do
  Dir['./config/initialisers/*.rb'].each { |f| require f }
  require 'pry'
  pry
end
