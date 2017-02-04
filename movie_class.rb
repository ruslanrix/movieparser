require_relative 'movie_modules.rb'
class Movie

  def self.create(row)
    class_name = case row[:year].to_i
    when 1900..1945
      AncientMovie
    when 1946..1968
      ClassicMovie
    when 1969..2000
      ModernMovie
    else NewMovie
    end
    class_name.new(row[:link], row[:movie], row[:year].to_i, row[:country],
    row[:release_date], row[:genre].split(','), row[:runtime].delete(" min").to_i,
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

  def to_s
    self.movie
  end
  
  attr_reader :link, :movie, :year, :country, :release_date, :genre, :runtime, :rating, :director, :actors
end

class AncientMovie < Movie
  def recommend_list
    puts "#{movie} - очень старый фильм (#{year} год), IMDB рейтинг: #{rating}"
  end
  RATE = 2
end

class ClassicMovie < Movie
  def recommend_list
    puts "#{movie} - классический фильм, вышедший в #{year} году. Режиссер #{director}."
  end
  RATE = 1
end
class ModernMovie < Movie
  def recommend_list
    puts "#{movie} - современное кино, в главных ролях играют #{actors}"
  end
  RATE = 4
end
class NewMovie < Movie
  def recommend_list
    puts "#{movie} - новинка, продолжительность фильма - #{runtime} минут"
  end
  RATE = 7
end
