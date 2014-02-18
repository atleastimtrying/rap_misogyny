require 'json'
require 'rapgenius'
require 'pry'

class LyricFetcher
  def get_rating name
    @songs = get_songs(name)
    if @songs.any?
      @lyrics = fetch_lyrics @songs
      ({ 
        rapper: @songs.first.artist.name,
        url: @songs.first.artist.url,
        lyrics: @lyrics,
        word_count: @lyrics.downcase.scan(/[a-z]+/).length,
        bitch_count: bitch_count(@lyrics)
      }).to_json
    else
      'no rapper found'
    end
  end
private
  def get_songs name
    RapGenius.search_by_artist name
  end

  def bitch_count string
    string.scan(/\ bitch\ |\ ho\ |\ hoe\ |\ ho\'s\ |\ hoes\ /).length
  end

  def fetch_lyrics songs
    songs.inject("") { |lyrics, song| lyrics + get_lyrics(song) }
  end

  def is_feminine string
    string.scan(/\ she\ |\ her\ |\ woman\ |\ girl\ |\ bitch\ |\ ho\ |\ lady\ |\ momma\ |\ ma\ |\ mom\ |\ hoe\ |\ ho\'s\ |\ hoes\ /).length > 0
  end

  def get_lyrics song
    song.lines.map(&:lyric).select {|lyric|
      is_feminine lyric
    }.join " "
  end
end
