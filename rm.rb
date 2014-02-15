require 'sinatra'
require 'json'
require 'rapgenius'
class Misogynator
  def get_rating name
    @songs = get_songs(name)
    if @songs.any?
      lyrics @songs
      { 
        rapper: @songs.first.artist.name,
        rapper_url: @songs.first.artist.url,
        word_count: lyrics.length,
        bitch_count: bitch_count(lyrics),
        bastard_count: bastard_count(lyrics),
        swear_count: swear_count(lyrics)
      }.to_json
    else
      'no rapper found'
    end
  end
private
  def get_songs name
    RapGenius.search_by_artist name
  end

  def bitch_count string
    string.scan(/bitch/).length
  end

  def bastard_count string
    string.scan(/bastard/).length
  end

  def swear_count string
    string.scan(/shit|fuck|cunt|arse|ass|wank|bastard|bitch|twat|bugger|bollocks/).length
  end

  def lyrics songs
    songs.inject("") {|lyrics, song| lyrics + get_lyrics(song) }
  end

  def get_lyrics song
    song.lines.map(&:lyric).join
  end
end

m = Misogynator.new

get '/' do
  send_file 'index.html'
end

get '/script.js' do
  send_file 'script.js'
end

get '/style.css' do
  send_file 'style.css'
end

get '/rating.json' do
  m.get_rating params[:name]
end