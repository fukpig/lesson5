# define class  Movie
class Movie
  attr_reader :href, :title, :release_year, :country, :release_date, :genre, :duration, :rating, :director, :actors
  attr_writer :href, :title, :release_year, :country, :release_date, :genre, :duration, :rating, :director, :actors

  def initialize(args)
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def has_genre?(genre)
    if @genre.include? genre
      return true
    end
    return false
  end

  def to_a

  end

  def to_s
    "#{@title} (#{@release_date}; #{@genre}) - #{@duration.split(" ")[0]} #{@duration.split(" ")[1]}"
  end

  def inspect
    "Movie(title: #{@title}, genre: #{@genre}, href: #{@href}, release_year: #{@release_year}, country: #{@country}, release_date: #{@release_date}, duration: #{@duration}, rating: #{@rating}, director: #{@director}, actors: #{@actors}, object_id: #{"0x00%x" % (object_id << 1)})"
  end
end
