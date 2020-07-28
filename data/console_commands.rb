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


#Matches Song AND Artist with Video description

  Song.all.each do |song|
    Video.where( "lower(unaccent(title)) like lower(unaccent(?)) AND lower(unaccent(title)) like lower(unaccent(?)) ", "%#{song.title}%", "%#{song.artist}%").each do |video|
      if video.song.nil?
      video.song = song
      video.save
      end
    end
  end

  #Matches Song AND Artist with Video title

  Song.all.each do |song|
    Video.where( "lower(unaccent(title)) like lower(unaccent(?))", "%#{song.title}%").each do |video|
      if video.song.nil?
      video.song = song
      video.save
      end
    end
  end

  #Matches Event with Video description

  Event.all.each do |event|
    Video.where( "lower(unaccent(description)) like lower(unaccent(?))", "%#{event.name}%").each do |video|
      video.event = event
      video.save
    end
  end

    #Matches Event with Video title

    Event.all.each do |event|
      Video.where( "lower(unaccent(title)) like lower(unaccent(?))", "%#{event.name}%").each do |video|
        video.event = event
        video.save
      end
    end

    #Matches Videotype with Video title
    Videotype.all.each do |videotype|
      Video.where( "lower(unaccent(title)) like lower(unaccent(?))", "%#{videotype.name}%").each do |video|
        video.videotype = videotype
        video.save
      end
    end

    #Matches Videotype with Video description

    Videotype.all.each do |videotype|
      Video.where( "lower(unaccent(description)) like lower(unaccent(?))", "%#{videotype.name}%").each do |video|
        video.videotype = videotype
        video.save
      end
    end



  #SQL match for Follower
  Follower.all.each do |follower|
    Video.all.where( "lower(unaccent(title)) like lower(unaccent(?))", "%#{follower.name}%").each do |video|
      video.follower = follower
      video.save
    end
  end

    #SQL match for Leader
    Leader.all.each do |leader|
      Video.all.where( "lower(unaccent(title)) like lower(unaccent(?))", "%#{leader.name}%").each do |video|
        video.leader = leader
        video.save
      end
    end

  # Video Type Parsing

video_types = 
              [ "class",
                "workshop",
                "performance",
                "documentary",
                "vlog",
                "interview",
                "short",
                "technique"
              ]

  video_types.each do |video_type|
  Video.all.where( "lower(unaccent(title)) like lower(unaccent(?))", "% #{video_type} %").each do |video|
    video.video_type = video_type 
    video.save
  end
end

/* Performance Number */
regExp = /\([\d]{1}([\/]+[\d]{1})\)/
split_value = "/(-)(/)/"
Video.all.each do |video|
  parsed_title = video.title.match(/\([\d]{1}([\/]+[\d]{1})\)/)
  performance_number = parsed_title.split("/")
  video.performance_number = performance_number.first 
  video.performance_total  = performance_number.last
video.save
end
