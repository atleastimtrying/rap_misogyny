require 'sinatra'
require './lyric_fetcher'

lyric_fetcher = LyricFetcher.new

get '/' do
  send_file 'index.html'
end

get '/script.js' do
  send_file 'script.js'
end

get '/style.css' do
  send_file 'style.css'
end

get '/favicon.ico' do
  send_file 'favicon.ico'
end

get '/rating.json' do
  if params[:name]
    lyric_fetcher.get_rating params[:name]
  else
    'please enter a name'
  end
end