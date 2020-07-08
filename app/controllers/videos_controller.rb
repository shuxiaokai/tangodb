class VideosController < ApplicationController

  def index
    @videos = Video.all.includes(:leader).limit(20)
  end
end
