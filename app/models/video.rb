class Video < ApplicationRecord
  class << self
    def for_channel(id)
      channel = Yt::Channel.new id: id
      channel.videos
    end
  end

end
