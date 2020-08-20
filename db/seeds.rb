require 'csv'

CSV.foreach('data/tangodb-datasets/Songs-Songs.csv', headers: true) do |column|
  genre = column[0]
  title = column[1]
  artist = column[2]
  Song.create(genre: genre, title: title, artist: artist) 
end
puts "There are now #{Song.count} Songs in the database."

CSV.foreach('data/tangodb-datasets/Videotypes-Videotypes.csv', headers: true) do |column|
   name = column[1]
  Videotype.create(name: name) 
end
puts "There are now #{Videotype.count} videotypes in the database."

CSV.foreach('data/tangodb-datasets/Events-Events.csv', headers: true) do |column|
  name = column[1]
  Event.create(name: name) 
end
puts "There are now #{Event.count} events in the database."

CSV.foreach('data/tangodb-datasets/Leaders-Leaders.csv', headers: true) do |column|
  name = column[1]
  Leader.create(name: name) 
end
puts "There are now #{Leader.count} leaders in the database."

CSV.foreach('data/tangodb-datasets/Followers-Followers.csv', headers: true) do |column|
  name = column[1]
  Follower.create(name: name) 
end
puts "There are now #{Follower.count} followers in the database."

CSV.foreach('data/tangodb-datasets/Videos-videos_dataset_master.csv', headers: true) do |column|
  title = column[3]
  youtube_id = column[4]
  description = column[7]
  channel = column[8]
  channel_id = column[9]
  duration = column[10]
  upload_date = column[11]
  view_count = column[12]
  avg_rating = column[13]
  tags = column[14]
  youtube_song = column[16]
  youtube_artist = column[17]
  Video.create( title: title, 
                youtube_id: youtube_id,
                description: description, 
                channel: channel, 
                channel_id: channel_id,
                duration: duration, 
                upload_date: upload_date, 
                view_count: view_count,
                avg_rating: avg_rating, 
                tags: tags, 
                youtube_song: youtube_song,
                youtube_artist: youtube_artist ) 
end
puts "There are now #{Video.count} videos in the database.