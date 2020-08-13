class VideosFilterController < ApplicationController
    def index
    video = Video
    video = video.where(channel: params[:channels]) unless params[:channels].size == 0
    video = video.includes(:leader).where(leader: params[:leaders]) unless params[:leaders].size == 0
    video = video.all if params[:leaders].size == 0 and params[:channels].size == 0
    @videos = video.where.not(leader: nil, follower: nil, song: nil).limit(100)
    end
    
  end