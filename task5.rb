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
userstore.class_rate(AncientMovie, 2)
userstore.class_rate(ClassicMovie, 1)
userstore.class_rate(ModernMovie, 1)
userstore.class_rate(NewMovie, 4)
puts
puts "5 random movies, which you didn't see:"
puts userstore.newmovies_advice
puts
puts "5 random movies, which you saw before:"
puts userstore.usermovies_advice
