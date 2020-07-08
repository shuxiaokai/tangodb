class VideosController < ApplicationController

  def index
    @videos = Video.all.includes(:leader).limit(500)
  end
end
