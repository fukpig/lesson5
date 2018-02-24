# define class  MovieCollection

require 'csv'
require './movie.rb'


class MovieCollection

  class FileNotFound < ArgumentError
    attr_reader :filename
      def initialize(filename)
        @filename = filename
        super("File #{filename} not found")
    end
  end

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

  def filter(filters)
    filters.reduce(@movies) { |filtered, (key, value)| filtered.select { |m| m.matches?(key, value) } }
  end

  def stats(field)
    @movies.collect(&field).each_with_object(Hash.new(0)) {|i,hash| hash[i] += 1}
  end

end
