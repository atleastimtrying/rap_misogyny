require 'json'
require 'rapgenius'
require 'pry'

class RapperData
  def self.get name
    @songs = get_songs(name)
    if @songs.any?
      @lyrics = fetch_lyrics @songs
      { 
        name: @songs.first.artist.name,
        url: @songs.first.artist.url,
        rating: self.rating(@lyrics)
      }
    end
  end

  def self.rating lyrics
    sprintf "%.2f", (self.bitch_count(lyrics) * 1.0 / self.word_count(lyrics) * 1.0) * 10000
  end

  def self.get_songs name
    RapGenius.search_by_artist name
  end

  def self.bitch_count string
    string.scan(/\ bitch\ |\ ho\ |\ hoe\ |\ ho\'s\ |\ hoes\ /).length
  end

  def self.word_count string
    string.downcase.scan(/[a-z]+/).length
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
