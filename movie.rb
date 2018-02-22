# define class  Movie
class Movie
  attr_reader :href, :title, :release_year, :country, :release_date, :genre, :duration, :rating, :director, :actors
  attr_writer :movie_collection

  ERROR_FIELD_NOT_FOUND = "field not found"
  ERROR_GENRE_NOT_FOUND = "genre not found"

  def initialize(args)
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def get_field(field)
    case field
    when :href
      return @href
    when :title
      return @title
    when :release_year
      return @release_year
    when :country
      return @country
    when :release_date
      return @release_date
    when :genre
      return @genre
    when :duration
      return @duration
    when :rating
      return @rating
    when :director
      return @director
    when :actors
      return @actors
    else
      raise ERROR_FIELD_NOT_FOUND
    end
  end

  def has_genre?(genre)
    if !@movie_collection.get_genres.include? genre
      raise ERROR_GENRE_NOT_FOUND
    end
    @genre.include? genre
  end

  def to_s
    "#{@title} (#{@release_date}; #{@genre}) - #{@duration.split(" ")[0]} #{@duration.split(" ")[1]}"
  end

  def inspect
    "Movie(title: #{@title}, genre: #{@genre}, href: #{@href}, release_year: #{@release_year}, country: #{@country}, release_date: #{@release_date}, duration: #{@duration}, rating: #{@rating}, director: #{@director}, actors: #{@actors})"
  end
end
