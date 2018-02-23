# define class  Movie
class Movie
  attr_reader :href, :title, :release_year, :country, :release_date, :genre, :full_duration_definition, :duration, :duration_definition, :rating, :director, :actors, :movie_collection

  ERROR_FIELD_NOT_FOUND = "field not found"
  ERROR_GENRE_NOT_FOUND = "genre not found"

  def initialize(args, movie_collection)
    args.map { |k,v| instance_variable_set("@#{k}", v) unless v.nil?}
    @movie_collection = movie_collection
    normalize_attributes
  end

  def normalize_attributes
    @release_year = @release_year.to_i
    @genre = @genre.split(',')
    @duration = @full_duration_definition.split(' ')[0].to_i
    @duration_definition = @full_duration_definition.split(' ')[1]
    @rating = @rating.to_i
    @actors = @actors.split(',')
  end

  def has_genre?(genre)
    if !@movie_collection.has_genre? genre
      raise ERROR_GENRE_NOT_FOUND
    end
    @genre.include? genre
  end

  def to_s
    "#{@title} (#{@release_date}; #{@genre.join(',')}) - #{@duration} #{@duration_definition}  #{@country}"
  end

  def inspect
    "Movie(title: #{@title}, genre: #{@genre}, href: #{@href}, release_year: #{@release_year}, country: #{@country}, release_date: #{@release_date}, duration: #{@duration}, duration: #{@duration_definition}, rating: #{@rating}, director: #{@director}, actors: #{@actors}, movie_collection: #{movie_collection})"
  end
end
