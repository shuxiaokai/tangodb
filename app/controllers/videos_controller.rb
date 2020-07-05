class VideosController < ApplicationController

  def index
    @videos = Video.all.limit(10)
  end
end
