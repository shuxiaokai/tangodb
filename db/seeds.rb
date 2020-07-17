require 'csv'
CSV.foreach('data/songs_dataset.csv') do |row|
  genre = row[0]
  title = row[1]
  artist = row[2]
  Song.create(genre: genre, title: title, artist: artist) 
end
puts "done" 