class VideosController < ApplicationController

  def index
    @videos = Video.for_channel('UCtdgMR0bmogczrZNpPaO66Q')
  end

end
