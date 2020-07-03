class VideosController < ApplicationController

  def index
    @channel = Yt::Channel.new id: 'UCtdgMR0bmogczrZNpPaO66Q'
  end

end
