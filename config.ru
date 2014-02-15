require 'rubygems'
require 'sinatra'
require 'json'
require 'rapgenius'
require './lyric_fetcher'
require './app'

Bundler.require(:default, ENV['RACK_ENV']) if defined?(Bundler)
run Sinatra::Application