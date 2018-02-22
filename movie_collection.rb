require 'csv'
require './movie.rb'
# define class  MovieCollection
class MovieCollection
  attr_reader :movies

  FILM_HASH_KEYS = %i[href title release_year country release_date genre duration rating director actors]
  ERROR_FILE_NOT_FOUND = "file not found"
  ERROR_INVALID_TYPE = "invalid type of value"

  def initialize(filename)
    if !File.file? filename
      raise ERROR_FILE_NOT_FOUND
    else
      @movies = CSV.read(filename, { headers: FILM_HASH_KEYS, col_sep: "|" }).map { |row| Movie.new(row.to_hash) }
      @movies.map { |m| m.movie_collection = self }
    end
  end

  def get_genres
    @genres = []
    @movies.collect {|movie| movie.genre.split(',').map{ |g| @genres << g} }
    return @genres.uniq
  end

  def inspect
    "MovieCollection(movies: #{@movies}, object_id: #{"0x00%x" % (object_id << 1)})"
  end

  def all
    @movies
  end

  def sort_by(field)
      case field
      when :duration
        @movies.sort_by { |movie| movie.duration.split(' ')[0].to_i }
      else
        @movies.sort_by(&field)
      end
  end

  def filter(hash)
    result_array = @movies
    hash.each do |key, value|
      case value
      when Regexp
        result_array = self.filter_by_regexp(result_array, key, value)
      when String
        result_array = self.filter_by_string(result_array, key, value)
      when Range
        result_array = self.filter_by_range(result_array, key, value)
      when Integer
        result_array = self.filter_by_integer(result_array, key,value)
      else
        raise ERROR_INVALID_TYPE
      end
    end
    return result_array
  end

  def stats(field)
    stats = {}
    @movies.map.with_index { |m,i| stats[m.get_field(field)].nil? ?  stats[m.get_field(field)] = 1 : stats[m.get_field(field)] += 1}
    return stats
  end

  protected

  def filter_by_regexp(result_array, key, value)
    result_array.select { |m| value.match? m.get_field(key) }
  end

  def filter_by_range(result_array, key, value)
    result_array.select { |m| value.include? m.get_field(key).to_i }
  end

  def filter_by_string(result_array, key, value)
    result_array.select { |m| m.get_field(key).include? value }
  end

  def filter_by_integer(result_array, key, value)
    result_array.select { |m| m.get_field(key).to_i == value }
  end

end
