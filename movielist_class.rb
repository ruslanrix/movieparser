require_relative 'movie_modules.rb'
class MovieList

  def initialize(filename)
    @movielist = CSV.new(File.read(filename), :headers => TITLES, :col_sep => '|')
    .map { |row| Movie.create(row) }
  end

  def longmovies(amount)
    @movielist.sort_by(&:runtime).last(amount).reverse
      .map{ |m| "Movie: #{m.movie}, runtime: #{m.runtime}" }
  end

  def shortmovies(amount)
    @movielist.sort_by(&:runtime).first(amount)
      .map{ |m| "Movie: #{m.movie}, runtime: #{m.runtime}" }
  end

  def reldate(genre)
    @movielist.sort_by(&:release_date).select{ |m| m.genre.include? genre }
      .map{ |m| "Movie: #{m.movie}, Release date: #{m.release_date}, Genre: #{m.genre}" }
  end

  def reldate_reverse(genre)
    @movielist.sort_by(&:release_date).reverse.select{ |m| m.genre.include? genre }
      .map{ |m| "Movie: #{m.movie}, Release date: #{m.release_date}, Genre: #{m.genre}" }
  end

  def except_genre(genre)
    @movielist.sort_by(&:release_date).select{ |m| !m.genre.include? genre }
      .map{ |m| "Movie: #{m.movie}, Release date: #{m.release_date}, Genre: #{m.genre}" }
  end

  def except_genre_reverse(genre)
    @movielist.sort_by(&:release_date).reverse.select{ |m| !m.genre.include? genre }
      .map{ |m| "Movie: #{m.movie}, Release date: #{m.release_date}, Genre: #{m.genre}" }
  end

  def all_directors
    @movielist.sort_by(&:director).uniq(&:director).map(&:director)
  end

  def stat_except_country (country)
    @movielist.reject{ |m| m.country.include? country }.length
  end

  def stat_country (country)
    @movielist.map{ |m| m.country.include? country }.length
  end

  def director_stats
    @movielist.group_by(&:director)
      .map{ |m, sum| [m, sum.length] }
      .to_h
  end

  def director_movies
    @movielist.group_by(&:director)
      .map{ |m, sum| " Director: #{m}, Movies: #{sum.map{ |row| [] << row.movie }.join(", ") }" }
  end

  def actor_stats
    @movielist.map{ |m| m.actors.split(',') }
      .flatten
      .reduce(Hash.new(0)){ |m, sum| m[sum] += 1; m }
  end

  def m_sort_by (input)
    @movielist.sort_by{ |m| m.send(input.to_sym) }
    .map{ |m| "Movie: #{m.movie}, Link: #{m.link}, Year: #{m.year},
      Country: #{m.country}, Release date: #{m.release_date}, Genre: #{m.genre},
      Runtime: #{m.runtime}, Rating: #{m.rating}, Director: #{m.director}, Actors: #{m.actors} "
    }
  end

  def m_sort_by_reverse (input)
    @movielist.sort_by{ |m| m.send(input.to_sym) }.reverse
    .map{ |m| "Movie: #{m.movie}, Link: #{m.link}, Year: #{m.year},
      Country: #{m.country}, Release date: #{m.release_date}, Genre: #{m.genre},
      Runtime: #{m.runtime}, Rating: #{m.rating}, Director: #{m.director}, Actors: #{m.actors} "
    }
  end

end
