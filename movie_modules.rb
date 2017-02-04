module MovieRate

  def initialize(filename)
    super(filename)
    @watched_movie = watched_movie
    @user_rating = user_rating
    @watched_date = watched_date
    @class_name = class_name
    @class_rating = class_rating
    @mymovielist = {}
    @sort_algo_collect = {}
    @filters = {}
  end
  attr_accessor :watched_movie, :user_rating, :watched_date, :class_name, :class_rating

  def rate(watched_movie, user_rating, watched_date)
    if @movielist.any? { |m| m.movie == watched_movie && m.year < watched_date }
      @mymovielist[watched_movie] = {}
      @mymovielist[watched_movie][:user_rating] = user_rating
      @mymovielist[watched_movie][:watched_date] = watched_date
    else
      puts "Error. The name of the movie '#{watched_movie}' is incorrect \
      or the watched date is earlier than the release year of the movie."
    end
  end
  
end
