class Movie
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
