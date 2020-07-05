class VideosController < ApplicationController

  def index
    @videos = Video.all.limit(200)
  end


  def show
    
  end

  def playlist
    @playlist = Video.all.limit(10)
  end

end
