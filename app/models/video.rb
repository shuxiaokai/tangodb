class Video < ApplicationRecord

  include Filterable

  DANCER_SEPARATOR = " and "
  SONG_SEPARATOR = %r( [–-] )
  HASHTAG_CLEANER = / #\w+\s*/

   validates :leader, presence: true
   validates :follower, presence: true
   validates :song, presence: true
   validates :artist, presence: true
   validates :youtube_id, presence: true
   validates :title, presence: true

  scope   :filter_by_leader_id,   -> (leader_id)    { where("leader_id = ?", leader_id) }
  scope   :filter_by_follower_id, -> (follower_id)  { where("follower_id = ?", follower_id) }

  belongs_to :leader
  belongs_to :follower

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

  class << self
    # To fetch video, run this from the console:
    # Video.parse_json('data/video_channel_data_json')
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
    #parsed_title = title.split(SONG_SEPARATOR)

    # Grep Leader from Title
    self.leader = Leader.all.find { |leader| title.match(leader.name) }
    self.follower = Follower.all.find { |follower| title.match(follower.name) }

    # song from Title
     #self.song = (parsed_title.last).gsub(/ #\w+\s*|,[\s\S\d\D]*$/, "")

    # # event from Description
    #  self.event = Video.description.split[/at (.*?) in, 1]
  end

end