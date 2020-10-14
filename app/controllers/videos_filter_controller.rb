class VideosFilterController < ApplicationController
  def index
    @videos = video.where(follower: params[:follower])
  end
end