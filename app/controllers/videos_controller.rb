class VideosController < ApplicationController

  def index
    # @videos = Video.for_channel('UCtdgMR0bmogczrZNpPaO66Q')
    @videos = Video.all
  end

end
