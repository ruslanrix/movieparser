require_relative 'movielist_class.rb'
require_relative 'movie_modules.rb'
class MyMoviesList < MovieList

include MovieRate
include MovieUserMethods

def initialize(filename)
  super(filename)
  @watched_movie = watched_movie
  @user_rating = user_rating
  @watched_date = watched_date
  @class_name = class_name
  @class_rating = class_rating
  @mymovielist = {}
end
attr_accessor :watched_movie, :user_rating, :watched_date, :class_name, :class_rating

end
