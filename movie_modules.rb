module MovieCommonMethods
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
    if Movie::descendants.any? { |c| c == class_name }
      @mymovielist[class_name] = {}
      @mymovielist[class_name][:class_rating] = class_rating
    else
      puts "Error. Wrong name of the class."
    end
  end
end

module MovieUserMethods
  def recommend_list(r_m)
    puts (if r_m.class == AncientMovie then "#{r_m.movie} - \
очень старый фильм (#{r_m.year} год), IMDB рейтинг: #{r_m.rating}"
    elsif r_m.class == ClassicMovie then "#{r_m.movie} - классический фильм, \
вышедший в #{r_m.year} году. Режиссер #{r_m.director}."
    elsif r_m.class == ModernMovie then "#{r_m.movie} - современное кино, \
в главных ролях играют #{r_m.actors}"
    else  "#{r_m.movie} - новинка, продолжительность фильма - #{r_m.runtime} минут"
    end)
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
