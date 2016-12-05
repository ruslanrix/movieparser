require_relative 'movielist_class.rb'
class MyMoviesList < MovieList
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
    if Movie::descendants.any? { |c| c == class_name }
      @mymovielist[class_name] = {}
      @mymovielist[class_name][:class_rating] = class_rating
    else
      puts "Error. Wrong name of the class."
    end
  end

  def recommend_list(r_m)
    puts (if r_m.class == AncientMovie then "#{r_m.movieinfo.movie} - \
очень старый фильм (#{r_m.movieinfo.year} год), IMDB рейтинг: #{r_m.movieinfo.rating}"
    elsif r_m.class == ClassicMovie then "#{r_m.movieinfo.movie} - классический фильм, \
вышедший в #{r_m.movieinfo.year} году. Режиссер #{r_m.movieinfo.director}."
    elsif r_m.class == ModernMovie then "#{r_m.movieinfo.movie} - современное кино, \
в главных ролях играют #{r_m.movieinfo.actors}"
    else  "#{r_m.movieinfo.movie} - новинка, продолжительность фильма - #{r_m.movieinfo.runtime} минут"
    end)
  end

  def newmovies_advice
    Movie::bydecade.reject { |m| @mymovielist.has_key?(m.movieinfo.movie) }
    .sort_by { |m| m.movieinfo.rating * rand(10) * @mymovielist[m.class][:class_rating] }
    .first(5)
    .map{ |m| recommend_list(m) }
  end

  def usermovies_advice
    Movie::bydecade.select { |m| @mymovielist.has_key?(m.movieinfo.movie) }
    .sort_by{ |m| @mymovielist[m.movieinfo.movie][:user_rating] * rand(10) *
    (Date.today.year - @mymovielist[m.movieinfo.movie][:watched_date]) * 10 *
    @mymovielist[m.class][:class_rating] }
    .first(5)
    .map{ |m| recommend_list(m) }
  end

end
