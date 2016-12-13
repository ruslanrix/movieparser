class Movie

  def self.descendants
    ObjectSpace.each_object(Class).select { |k| k < self }
  end

  def self.create(row)
    if row[:year].to_i.between?(1900,1945)
      return AncientMovie.new(row[:link], row[:movie], row[:year], row[:country],
      row[:release_date], row[:genre], row[:runtime].delete(" min").to_i,
      row[:rating], row[:director], row[:actors])
    elsif row[:year].to_i.between?(1946,1968)
      return ClassicMovie.new(row[:link], row[:movie], row[:year], row[:country],
      row[:release_date], row[:genre], row[:runtime].delete(" min").to_i,
      row[:rating], row[:director], row[:actors])
    elsif row[:year].to_i.between?(1969,2000)
      return ModernMovie.new(row[:link], row[:movie], row[:year], row[:country],
      row[:release_date], row[:genre], row[:runtime].delete(" min").to_i,
      row[:rating], row[:director], row[:actors])
    else
      return NewMovie.new(row[:link], row[:movie], row[:year], row[:country],
      row[:release_date], row[:genre], row[:runtime].delete(" min").to_i,
      row[:rating], row[:director], row[:actors])
    end
    attr_reader :row
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
  def initialize(link, movie, year, country, release_date, genre, runtime, rating, director, actors)
    super
  end
end

class ClassicMovie < Movie
  def initialize(link, movie, year, country, release_date, genre, runtime, rating, director, actors)
    super
  end
end

class ModernMovie < Movie
  def initialize(link, movie, year, country, release_date, genre, runtime, rating, director, actors)
    super
  end
end

class NewMovie < Movie
  def initialize(link, movie, year, country, release_date, genre, runtime, rating, director, actors)
    super
  end
end
