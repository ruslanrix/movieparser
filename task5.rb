#encoding: utf-8
require 'csv'
require 'date'
require_relative 'movie_class.rb'
require_relative 'movielist_class.rb'
require_relative 'mymovielist_class.rb'
TITLES = [:link, :movie, :year, :country, :release_date, :genre, :runtime, :rating, :director, :actors]

moviefile = ARGV.join("")
abort("File not found: #{moviefile}") unless File.exist?(moviefile)
userstore = MyMoviesList.new(moviefile)
amount = 10
genre = "Sci-Fi"
country = "USA"
input = "runtime"
puts "#{amount} LONGEST MOVIES:"
puts userstore.longmovies(amount)
puts
puts "#{amount} SHORTEST MOVIES:"
puts userstore.shortmovies(amount)
puts
puts "ALL #{genre.upcase} MOVIES, SORTED BY RELEASE DATE"
puts userstore.reldate(genre)
puts
puts "ALL #{genre.upcase} MOVIES, SORTED IN DESCENDING ORDER BY RELEASE DATE"
puts userstore.reldate_reverse(genre)
puts
puts "ALL MOVIES EXCEPT #{genre.upcase} GENRE, SORTED BY RELEASE DATE"
puts userstore.except_genre(genre)
puts
puts "ALL MOVIES EXCEPT #{genre.upcase} GENRE, SORTED IN DESCENDING ORDER BY RELEASE DATE"
puts userstore.except_genre_reverse(genre)
puts
puts "LIST OF ALL MOVIE DIRECTORS"
puts userstore.all_directors
puts
puts "AMOUNT OF MOVIES, WHICH WERE NOT SHOT IN THE #{country.upcase}"
puts userstore.stat_except_country(country)
puts
puts "AMOUNT OF MOVIES, WHICH WERE SHOT IN THE #{country.upcase}"
puts userstore.stat_country(country)
puts
puts "AMOUNT OF MOVIES, GROUPED BY DIRECTOR"
puts userstore.director_stats
puts
puts "MOVIES, GROUPED BY DIRECTOR"
puts userstore.director_movies
puts
puts "AMOUNT OF MOVIES, WHERE EACH ACTOR WAS SHOOTED"
puts userstore.actor_stats
puts
puts "LIST OF MOVIES SORTED BY THE FIELD #{input.upcase}"
puts userstore.m_sort_by(input)
puts
puts "LIST OF MOVIES SORTED IN DESCENDING ORDER BY THE FIELD #{input.upcase}"
puts userstore.m_sort_by_reverse(input)
userstore.rate("The Shawshank Redemption", 10, 2012)
userstore.rate("The Godfather", 9, 2010)
userstore.rate("The Dark Knight", 9, 2010)
userstore.rate("Inception", 9, 2011)
userstore.rate("Interstellar", 7, 2015)
userstore.rate("Whiplash", 8, 2016)
userstore.rate("Inside Out", 8, 2016)
userstore.rate("The Grand Budapest Hotel", 8, 2015)
userstore.rate("The Avengers", 8, 2014)
userstore.rate("wazzzzzup", 5, 2010)
puts
puts "5 random movies, which you didn't see:"
puts userstore.newmovies_advice
puts
puts "5 random movies, which you saw before:"
puts userstore.usermovies_advice
userstore.print{ |movie| "#{movie.year}: #{movie.movie}" }
puts "This list was sorted by genre and year"
puts userstore.sorted_by{ |movie| [movie.genre, movie.year] }
userstore.add_sort_algo(:genres_years) { |movie| [movie.genre, movie.year] }
puts "This list was sorted  by sort algorithm"
puts userstore.sort_by(:genres_years)
puts userstore.sort_by(:geweenrffes_yesdfsdfars)
# userstore.add_filter(:box_office_greater){|movie, usd| movie.box_office > usd}
userstore.add_filter(:genres){|movie, *genres| genres.include?(movie.genre)}
userstore.add_filter(:years){|movie, from, to| (from..to).include?(movie.year)}
puts "TEST"
puts userstore.filter(
    genres: ['Comedy', 'Horror'],
    years: [2005, 2010],
    # box_office_greater: 30_000_000
  )
