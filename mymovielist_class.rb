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

  def recommend_list(r_m)
    if r_m.class == AncientMovie
      "#{r_m.movie} - очень старый фильм (#{r_m.year} год), IMDB рейтинг: #{r_m.rating}"
    elsif r_m.class == ClassicMovie
      "#{r_m.movie} - классический фильм, вышедший в #{r_m.year} году. Режиссер #{r_m.director}."
    elsif r_m.class == ModernMovie
      "#{r_m.movie} - современное кино, в главных ролях играют #{r_m.actors}"
    else
      "#{r_m.movie} - новинка, продолжительность фильма - #{r_m.runtime} минут"
    end
  end

end
