require_relative 'movie_modules.rb'
class Movie

  def self.create(row)
    @class_name = case row[:year].to_i
    when 1900..1945
      AncientMovie
    when 1946..1968
      ClassicMovie
    when 1969..2000
      ModernMovie
    else NewMovie
    end
    @class_name.new(row[:link], row[:movie], row[:year], row[:country],
    row[:release_date], row[:genre], row[:runtime].delete(" min").to_i,
    row[:rating], row[:director], row[:actors])
  end

  def initialize(link, movie, year, country, release_date, genre, runtime, rating, director, actors)
    @link = link
    @movie = movie
    @year = year
    @country = country
    @release_date = release_date
    @genre = genre
    @runtime = runtime
    @rating = rating
    @director = director
    @actors = actors
  end

  attr_reader :link, :movie, :year, :country, :release_date, :genre, :runtime, :rating, :director, :actors
end

["AncientMovie", "ClassicMovie", "ModernMovie", "NewMovie"]
  .each{ |klass| eval "class #{klass} < Movie; end"}
