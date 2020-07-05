class Video < ApplicationRecord
  DANCER_SEPARATOR = " and "
  SONG_SEPARATOR = %r( [–-] )

  validates :leader, presence: true
  validates :follower, presence: true
  validates :song, presence: true
  validates :youtube_id, presence: true
  validates :title, presence: true

  belongs_to :leader

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

  def grep_title
    parsed_title = title.split(SONG_SEPARATOR)

    # Grep Leader from Title
    self.leader = Leader.all.find { |leader| title.match(leader.name) }

    self.follower = "Whatever"
    # self.follower = Follower.all.find { |leader| title.match(leader.name) }

    # song from Title
     self.song = parsed_title.last
  end
end
