Leader.all.each do |leader|
  Video.search_by_keyword("\"#{leader.name}\"").each do |video|
    if video.leader.nil?
      video.leader = leader
    end
    video.save
  end
end

Follower.all.each do |follower|
  Video.search_by_keyword("\"#{follower.name}\"").each do |video|
    if video.follower.nil?
      video.follower = follower
    end
    video.save
  end
end

Video.all.each do |video|
  video.leader = Leader.all.find { |leader| video.description.match(leader.name) }
  video.save
  end

Video.all.each do |video|
  video.follower = Follower.all.find { |follower| video.description.match(follower.name) }
  video.save
  end


#Matches Song AND Artist with Video

  Song.all.each do |song|
    Video.all.where( "lower(unaccent(description)) like lower(unaccent(?)) AND lower(unaccent(description)) like lower(unaccent(?)) ", "%#{song.title}%", "%#{song.artist}%").each do |video|
      video.song = song
      video.save
    end
  end

  #SQL match for Leader
  Leader.all.each do |leader|
    Video.all.joins(:leader).where( "lower(unaccent(description)) like lower(unaccent(?))", "%#{leader.name}%").each do |video|
      video.leader = leader
      video.save
    end
  end

  #SQL match for Follower
  Follower.all.each do |follower|
    Video.all.joins(:follower).where( "lower(unaccent(description)) like lower(unaccent(?))", "%#{follower.name}%").each do |video|
      video.follower = follower
      video.save
    end
  end
[
  "Class",
  "Workshop",
  "Performance",
  "Documentary",
  "Vlog",
  "Interview",
  "Short",
  "Technique",
  "Maestro Ronda",
  

]
  Video.all.joins(:follower).where( "lower(unaccent(description)) like lower(unaccent(?))", "%#{follower.name}%").each do |video|