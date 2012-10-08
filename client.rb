#!/usr/bin/env ruby

require 'bundler/setup'
Bundler.require(:default, :development)

require 'drb/drb'

DRb.start_service

play = DRbObject.new_with_uri("druby://localhost:8787")
tracks = play.search('end of the road')

binding.pry
