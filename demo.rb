require './movie_collection.rb'
movies = MovieCollection.new("movies.txt")

begin
  puts movies.all.first(5)

  puts "--------"

  puts movies.sort_by(:duration)

  puts "--------"

  puts movies.filter(release_year: 2015, title: 'Mad')

  puts "--------"

  puts movies.stats(:director)

  puts "--------"

  puts movies.all.first.has_genre? "Comedy"

  puts "--------"

  puts movies.all.first.has_genre? "Tragedy"

rescue Exception => e
  puts "get error \"#{e}\""
end
