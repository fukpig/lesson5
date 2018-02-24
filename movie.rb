# define class  Movie
require './errors/genre_not_found.rb'
class Movie
  attr_reader :href, :title, :release_year, :country, :release_date, :genre, :full_duration_definition, :duration, :duration_definition, :rating, :director, :actors, :movie_collection

  def initialize(args, movie_collection)
    args.map { |k,v| instance_variable_set("@#{k}", v) unless v.nil?}
    @movie_collection = movie_collection
    normalize_attributes
  end

  def has_genre?(genre)
    raise GenreNotFound.new(genre) unless @movie_collection.has_genre? genre
    @genre.include? genre
  end

  def to_s
    "#{@title} (#{@release_date}; #{@genre.join(',')}) - #{@duration} #{@duration_definition}  #{@country}"
  end

  def inspect
    "Movie(\"#{@title}\" (#{@release_year}))"
  end

  private
  def normalize_attributes
    @release_year = @release_year.to_i
    @genre = @genre.split(',')
    @duration = @full_duration_definition.split(' ')[0].to_i
    @duration_definition = @full_duration_definition.split(' ')[1]
    @rating = @rating.to_i
    @actors = @actors.split(',')
  end
end
