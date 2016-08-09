#encoding: utf-8
require 'csv'
require 'date'
require_relative 'task5_movie_class.rb'
require_relative 'task5_movielist_class.rb'
TITLES = [:link, :movie, :year, :country, :release_date, :genre, :runtime, :rating, :director, :actors]

moviefile = ARGV.join("")
abort("File not found: #{moviefile}") unless File.exist?(moviefile)
store = MovieList.new(moviefile)
amount = 10
genre = "Sci-Fi"
country = "USA"
input = "runtime"
puts "#{amount} LONGEST MOVIES:"
puts store.longmovies(amount)
puts
puts "#{amount} SHORTEST MOVIES:"
puts store.shortmovies(amount)
puts
puts "ALL #{genre.upcase} MOVIES, SORTED BY RELEASE DATE"
puts store.reldate(genre)
puts
puts "ALL #{genre.upcase} MOVIES, SORTED IN DESCENDING ORDER BY RELEASE DATE"
puts store.reldate_reverse(genre)
puts
puts "ALL MOVIES EXCEPT #{genre.upcase} GENRE, SORTED BY RELEASE DATE"
puts store.except_genre(genre)
puts
puts "ALL MOVIES EXCEPT #{genre.upcase} GENRE, SORTED IN DESCENDING ORDER BY RELEASE DATE"
puts store.except_genre_reverse(genre)
puts
puts "LIST OF ALL MOVIE DIRECTORS"
puts store.all_directors
puts
puts "AMOUNT OF MOVIES, WHICH WERE NOT SHOT IN THE #{country.upcase}"
puts store.stat_except_country(country)
puts
puts "AMOUNT OF MOVIES, WHICH WERE SHOT IN THE #{country.upcase}"
puts store.stat_country(country)
puts
puts "AMOUNT OF MOVIES, GROUPED BY DIRECTOR"
puts store.director_stats
puts
puts "MOVIES, GROUPED BY DIRECTOR"
puts store.director_movies
puts
puts "AMOUNT OF MOVIES, WHERE EACH ACTOR WAS SHOOTED"
puts store.actor_stats
puts
puts "LIST OF MOVIES SORTED BY THE FIELD #{input.upcase}"
puts store.m_sort_by(input)
puts
puts "LIST OF MOVIES SORTED IN DESCENDING ORDER BY THE FIELD #{input.upcase}"
puts store.m_sort_by_reverse(input)
