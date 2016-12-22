module MovieRate
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

  def newmovies_advice
    @movielist.reject { |m| @mymovielist.has_key?(m.movie) }
    .sort_by { |m| m.rating * rand(10) * @mymovielist[m.class][:class_rating] }
    .first(5)
    .map{ |m| recommend_list(m) }
  end

  def usermovies_advice
    @movielist.select { |m| @mymovielist.has_key?(m.movie) }
    .sort_by{ |m| @mymovielist[m.movie][:user_rating] * rand(10) *
    (Date.today.year - @mymovielist[m.movie][:watched_date]) * 10 *
    @mymovielist[m.class][:class_rating] }
    .first(5)
    .map{ |m| recommend_list(m) }
  end

end
