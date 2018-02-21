require 'csv'
require './movie.rb'
# define class  MovieCollection
class MovieCollection
  attr_reader :movies
  attr_writer :movies

  FILM_HASH_KEYS = %i[href title release_year country release_date genre duration rating director actors]

  def initialize(filename)
    if !File.file? filename
      puts "source file not found"
    else
      @movies = CSV.read(filename, { headers: FILM_HASH_KEYS, col_sep: "|" }).map { |row| Movie.new(row.to_hash) }
    end
  end

  def inspect
    "MovieCollection(movies: #{@movies}, object_id: #{"0x00%x" % (object_id << 1)})"
  end

  def all
    @movies
  end

  def sort_by(field)
    @movies.sort_by(&field)
  end

  def filter(hash)
    key, value = hash.first
    @movies.select { |m| m.instance_variable_get("@#{key}").include? value }
  end

  def stats(field)
    stats = {}
    @movies.map.with_index { |m,i| stats[m.instance_variable_get("@#{field}")].nil? ?  stats[m.instance_variable_get("@#{field}")] = 1 : stats[m.instance_variable_get("@#{field}")] += 1}
    return stats
  end
end
