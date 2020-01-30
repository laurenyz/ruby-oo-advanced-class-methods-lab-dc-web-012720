require 'pry'
class Song
  attr_accessor :name, :artist_name
  @@all = []

  # def initialize
  #   self.save
  # end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  #@song is an object
  def self.create
    @song = Song.new
    @song.save
    @song
  end

  def self.new_by_name(name)
    @song = Song.new
    @song.name = name
    @song
  end

  def self.create_by_name(name)
    @song = self.create
    @song.name = name
    @song
  end

  def self.find_by_name(name)
    @@all.find {|songs| songs.name == name}
  end

  def self.find_or_create_by_name(name)
    if Song.find_by_name(name)
      Song.find_by_name(name)
    else 
      Song.create_by_name(name)
    end
  end

  def self.alphabetical
    alphabetized_names = []
    @@all.each {|song_object| alphabetized_names << song_object.name}
    alphabetized_names.sort.map do |song_name| 
      Song.find_by_name(song_name)
    end
  end

  def self.new_from_filename(filename)
    no_dash = filename.gsub(" - ", ",")
    no_period = no_dash.gsub(".", ",")
    split_artist_filename = no_period.split(",")
    @song = Song.create_by_name(split_artist_filename[1])
    @song.artist_name = split_artist_filename[0]
    @song
  end

  def self.create_from_filename(filename)
    @song = Song.new_from_filename(filename)
    @song.save 
  end

  def self.destroy_all
    @@all = []
  end
end

# Song.create_by_name("Help")
# Song.create_by_name("Sugar")
# Song.create_by_name "I'm Bringing Sexy Back"

# p Song.alphabetical

p Song.new_from_filename("Taylor Swift - Blank Space.mp3")

