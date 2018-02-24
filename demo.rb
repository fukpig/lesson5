require './movie_collection.rb'
movies = MovieCollection.new("movies.txt")

begin
  puts movies.all.first(5)

  puts "--------"

  puts movies.sort_by(:duration)

  puts "--------"

  puts movies.filter(release_year: 2010..2015, genre: /Comedy/i, actors: /Ralph/i)

  puts "--------"

  puts movies.stats(:director)

  puts "--------"

  puts movies.all.first.has_genre? "Comedy"

  puts "--------"

  puts movies.all.first.has_genre? "Tragedy"

rescue Exception => e
  puts e.message
end
