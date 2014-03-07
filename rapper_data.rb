require 'json'
require 'rapgenius'
require 'pry'

class RapperData
  def self.get name
    @songs = get_songs(name)
    if @songs.any?
      @lyrics = fetch_lyrics @songs
      { 
        rapper: @songs.first.artist.name,
        url: @songs.first.artist.url,
        lyrics: @lyrics,
        word_count: @lyrics.downcase.scan(/[a-z]+/).length,
        bitch_count: bitch_count(@lyrics)
      }
    end
  end

  def self.get_songs name
    RapGenius.search_by_artist name
  end

  def self.bitch_count string
    string.scan(/\ bitch\ |\ ho\ |\ hoe\ |\ ho\'s\ |\ hoes\ /).length
  end

  def self.fetch_lyrics songs
    songs.inject("") { |lyrics, song| lyrics + get_lyrics(song) }
  end

  def self.is_feminine string
    string.scan(/\ she\ |\ her\ |\ woman\ |\ girl\ |\ bitch\ |\ ho\ |\ lady\ |\ momma\ |\ ma\ |\ mom\ |\ hoe\ |\ ho\'s\ |\ hoes\ /).length > 0
  end

  def self.get_lyrics song
    song.lines.map(&:lyric).select {|lyric|
      is_feminine lyric
    }.join " "
  end
end
