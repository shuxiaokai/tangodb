class Video < ApplicationRecord
  DANCER_SEPARATOR = " and "
  SONG_SEPARATOR = %r( [–-] )

  validates :leader, presence: true
  validates :follower, presence: true
  validates :song, presence: true

  class << self
    # To fetch video, run this from the console:
    # Video.for_channel('UCtdgMR0bmogczrZNpPaO66Q')
    def for_channel(id)
      channel = Yt::Channel.new id: id
      channel.videos.each do |youtube_video|
        video = Video.new(youtube_id: youtube_video.id)
        video.parse_title(youtube_video.title)
        video.save
      end
    end
  end

  def parse_title(title)
    # TODO: ensure that the title has the right format
    # follower and leader - song
    return unless title.match(/.+#{DANCER_SEPARATOR}.+#{SONG_SEPARATOR}.+/)
    parsed_title = title.split(SONG_SEPARATOR)

    dancers = parsed_title.first
    self.song = parsed_title.last

    parsed_dancers = dancers.split(DANCER_SEPARATOR)
    self.follower = parsed_dancers.first
    self.leader = parsed_dancers.last
  end
end
