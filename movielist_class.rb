require_relative 'movie_modules.rb'
class MovieList

include MovieCommonMethods

def initialize(filename)
  @movielist = CSV.new(File.read(filename), :headers => TITLES, :col_sep => '|')
  .map { |row| Movie.create(row) }
end

end
