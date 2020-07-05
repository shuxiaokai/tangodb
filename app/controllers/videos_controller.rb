class VideosController < ApplicationController

  def index
    @videos = Video.all.includes(:leader).limit(10)
  end
end
