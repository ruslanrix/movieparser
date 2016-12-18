class Movie
  
  def self.descendants
    ObjectSpace.each_object(Class).select { |k| k < self }
  end

  def self.create(row)
    @class_name = case row[:year].to_i
    when 1900..1945
      AncientMovie
    when 1946..1968
      ClassicMovie
    when 1969..2000
      ModernMovie
    when 2000..2017
      NewMovie
    end
    attr_reader :row
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

class AncientMovie < Movie
  def
    super
  end
end

class ClassicMovie < Movie
  def
    super
  end
end

class ModernMovie < Movie
  def
    super
  end
end

class NewMovie < Movie
  def
    super
  end
end
