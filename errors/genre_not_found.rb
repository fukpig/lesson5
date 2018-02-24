class GenreNotFound < ArgumentError
  attr_reader :genre
    def initialize(genre)
      @genre = genre
      super("Genre #{genre} not found")
  end
end
