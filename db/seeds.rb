require 'csv'
CSV.foreach('data/songs_dataset.csv') do |row|
  genre = row[0]
  title = row[1]
  artist = row[2]
  Song.create(genre: genre, title: title, artist: artist) 
end
puts "done" 

CSV.foreach('data/videotype_dataset.csv') do |row|
   name = row[0]
  Videotype.create(name: name) 
end
puts "done" 

CSV.foreach('data/events_dataset.csv') do |row|
  name = row[0]
  Event.create(name: name) 
end
puts "done" 