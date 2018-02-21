require './movie_collection.rb'
movies = MovieCollection.new("movies.txt")

puts movies.all.first(5)

puts "--------"

puts movies.sort_by(:title)

puts "--------"

puts movies.filter(genre: 'Comedy').first(5)

puts "--------"

puts movies.stats(:release_year)

puts "--------"

puts movies.all.first.has_genre? "Comedy"
