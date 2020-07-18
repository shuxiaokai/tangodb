class Video < ApplicationRecord

  include Filterable

  validates :leader, presence: true
  validates :follower, presence: true
  #validates :song, presence: true
  #validates :artist, presence: true
  validates :youtube_id, presence: true, uniqueness: true
  validates :title, presence: true

  scope   :filter_by_leader_id,   -> (leader_id)    { where("leader_id = ?",   leader_id) }
  scope   :filter_by_follower_id, -> (follower_id)  { where("follower_id = ?", follower_id) }

  belongs_to :leader
  belongs_to :follower

  class << self
    # To fetch video, run this from the console:
    # Video.parse_json('data/030tango_channel_data_json')
    # Video.parse_json('/Users/justin/data/channel_json')
    def parse_json(file_path)
      json_file = Dir.glob("#{file_path}/**/*.json").map 
      json_file.each do |youtube_video|
          video = JSON.parse(File.read(youtube_video))
          video = Video.new(
                          youtube_id: video["id"], 
                          title: video["title"],
                          description: video["description"],
                          song: video["track"],
                          artist: video["artist"],
                          upload_date: video["upload_date"],
                          channel: video["uploader"],
                          duration: video["duration"],
                          channel_id: video["uploader_id"],
                          view_count: video["view_count"],
                          avg_rating: video["average_rating"],
                          tags: video["tags"]
                        )
           video.grep_title
           video.save
       end 
    end
  end

  def grep_title

    # Grep Leader from Title
    self.leader = Leader.all.find { |leader| title.match(leader.name) }
    # Grep Follower from Title
    self.follower = Follower.all.find { |follower| title.match(follower.name) }
    # Grep song from Title
      # if self.song.nil?
      
      #   self.song = Song.all.find { |song| title.match(song.title) }
      #   self.artist = Song.all.find { |artist| title.match(song.artist) }
      
      # end

    #Grep Arist from Title
      #if self.artist.nil?

      #  self.artist = Song.all.find { |artist| title.match(song.artist)}

     # end

    # grep genre from song 
    # self.genre = find_by(Song.name)  

    #Grep type 
    # if leader follower song artist full 
    #   self.type = 'Performance'
    # end

    # if title = 'short'
    #   self.type = 'short'
    # end

    # if title = 'interview'
    #   self.type = 'interview'
    # end

    # if title = 'technique'
    #   self.type = 'technique'
    # end

    # if title = 'vlog'
    #   self.type = 'vlog'
    # end

    # if title = 'documentary'
    #   self.type = 'documentary'
    # end

    # if title = 'workshop'
    #   self.type = 'workshop'
    # end

    # if title = 'class'
    #   self.type = 'class'
    # end

    # Grep performance number from title

    # Grep performance date from title

    # event from Description
     #self.event = Video.description { |event| title.match(event.title)}
  end


  class << self
    # To fetch video, run this from the console:
    # Video.for_channel('UCtdgMR0bmogczrZNpPaO66Q')
    def for_channel(id)
      channel = Yt::Channel.new id: id
      channel.videos.each do |youtube_video|
        video = Video.new(youtube_id: youtube_video.id, title: youtube_video.title)
        video.grep_title
        video.save
      end
    end
  end

end