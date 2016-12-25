require_relative 'movielist_class.rb'
require_relative 'movie_modules.rb'
class MyMoviesList < MovieList

  include MovieRate

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

  def rate(watched_movie, user_rating, watched_date)
    if @movielist.any? { |m| m.movie == watched_movie && m.year < watched_date.to_s }
      @mymovielist[watched_movie] = {}
      @mymovielist[watched_movie][:user_rating] = user_rating
      @mymovielist[watched_movie][:watched_date] = watched_date
    else
      puts "Error. The name of the movie '#{watched_movie}' is incorrect \
      or the watched date is earlier than the release year of the movie."
    end
  end
  
  def class_rate(class_name, class_rating)
    if Object.const_defined? ("#{class_name}")
      @mymovielist[class_name] = {}
      @mymovielist[class_name][:class_rating] = class_rating
    else
      puts "Error. Wrong name of the class."
    end
  end

end
