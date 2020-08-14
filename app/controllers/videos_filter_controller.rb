class VideosFilterController < ApplicationController
    def index
    video = Video
    video = video.where(channel: params[:channels]) unless params[:channels].size == 0
    video = video.includes(:leader).where(leader: params[:leaders]) unless params[:leaders].size == 0
    video = video.includes(:follower).where(follower: params[:followers]) unless params[:followers].size == 0
    video = video.includes(:event).where(event: params[:events]) unless params[:events].size == 0
    video = video.includes(:videotype).where(videotype: params[:videotypes]) unless params[:videotypes].size == 0
    video = video.includes(:song).where(:songs => {:genre => params[:genres] }) unless params[:genres].size == 0
    video = video.all if params[:leaders].size == 0 and params[:followers].size == 0 and params[:channels].size == 0 and params[:events].size == 0 and params[:videotypes].size == 0 and params[:genres].size == 0
    @videos = video.where.not(leader: nil, follower: nil, song: nil).limit(100)
    end
    
  end