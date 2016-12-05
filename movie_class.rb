class Movie
  @@bydecade = Array.new

  def self.bydecade
    @@bydecade
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |k| k < self }
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
    if year.to_i.between?(1900,1945)
      @@bydecade.push(AncientMovie.new(self))
    elsif year.to_i.between?(1946,1968)
      @@bydecade.push(ClassicMovie.new(self))
    elsif year.to_i.between?(1969,2000)
      @@bydecade.push(ModernMovie.new(self))
    else
      @@bydecade.push(NewMovie.new(self))
    end
  end

  attr_reader :link, :movie, :year, :country, :release_date, :genre, :runtime, :rating, :director, :actors
end

class AncientMovie < Movie
  def initialize(movieinfo)
    @movieinfo = movieinfo
  end
  attr_reader :movieinfo
end

class ClassicMovie < Movie
  def initialize(movieinfo)
    @movieinfo = movieinfo
  end
  attr_reader :movieinfo
end

class ModernMovie < Movie
  def initialize(movieinfo)
    @movieinfo = movieinfo
  end
  attr_reader :movieinfo
end

class NewMovie < Movie
  def initialize(movieinfo)
    @movieinfo = movieinfo
  end
  attr_reader :movieinfo
end
