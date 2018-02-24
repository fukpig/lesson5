require 'csv'
require './movie.rb'
require './errors/file_not_found.rb'
# define class  MovieCollection
class MovieCollection
  attr_reader :movies, :genres

  FILM_HASH_KEYS = %i[href title release_year country release_date genre full_duration_definition rating director actors]

  def initialize(filename)
    raise FileNotFound.new(filename) unless File.file? filename
    @movies = CSV.read(filename, { headers: FILM_HASH_KEYS, col_sep: "|" }).map { |row| Movie.new(row.to_hash, self) }

    @genres = @movies.flat_map(&:genre).uniq
  end

  def has_genre?(genre)
    @genres.include? genre
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
      filtered = filtered.reduce([]) { |array, movie| Array(movie.send(key)).any? { |v| value === v} ?  array.push(movie) : array }
    end
    return filtered

=begin
    filtered = @movies
    hash.map do |key, value|
      filtered = filtered.select do |m|
        Array(m.send(key)).any? { |v| value === v}
      end
    end
    return filtered
=end
  end

  def stats(field)
    @movies.collect(&field).each_with_object(Hash.new(0)) {|i,hash| hash[i] += 1}
  end

end
