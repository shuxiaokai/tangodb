class VideosController < ApplicationController

  def index
    @videos = Video.all.includes(:leader).limit(1000)
  end
end
