module MovieRate

  def newmovies_advice
    @movielist.reject { |m| @mymovielist.has_key?(m.movie) }
    .sort_by { |m| m.rating * rand(10) * @mymovielist[m.class][:class_rating] }
    .first(5)
    .map{ |m| m.recommend_list }
  end

  def usermovies_advice
    @movielist.select { |m| @mymovielist.has_key?(m.movie) }
    .sort_by{ |m| @mymovielist[m.movie][:user_rating] * rand(10) *
    (Date.today.year - @mymovielist[m.movie][:watched_date]) * 10 *
    @mymovielist[m.class][:class_rating] }
    .first(5)
    .map{ |m| m.recommend_list }
  end

end
