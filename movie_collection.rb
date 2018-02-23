require 'csv'
require './movie.rb'
# define class  MovieCollection
class MovieCollection
  attr_reader :movies, :genres

  FILM_HASH_KEYS = %i[href title release_year country release_date genre full_duration_definition rating director actors]
  ERROR_FILE_NOT_FOUND = "file not found"
  ERROR_INVALID_TYPE = "invalid type of value"

  def initialize(filename)
    if !File.file? filename
      raise ERROR_FILE_NOT_FOUND
    else
      @movies = CSV.read(filename, { headers: FILM_HASH_KEYS, col_sep: "|" }).map { |row| Movie.new(row.to_hash, self) }
    end

    @genres = @movies.collect{|movie| movie.genre }.flatten.uniq
  end

  def has_genre?(genre)
    return @genres.include? genre
  end

  def inspect
    "MovieCollection(movies: #{@movies})"
  end

  def all
    @movies
  end

  def sort_by(field)
      @movies.sort_by(&field)
  end

  def filter(hash)
    filtered = @movies
    hash.map do |key, value|
      filtered = filtered.select do |m|
        Array(m.send(key)).any? { |v| value === v}
      end
    end
    return filtered
  end

  def stats(field)
    stats = @movies.collect{ |m| m.send(field)}.each_with_object(Hash.new(0)) {|i,hash| hash[i] += 1}
  end

end
