class VideosFilterController < ApplicationController
    def index
    video = Video
    video = video.where(channel: params[:channels]) unless params[:channels].all?(&:blank?)
    video = video.includes(:leader).where(leader: params[:leaders]) unless params[:leaders].all?(&:blank?)
    video = video.includes(:follower).where(follower: params[:followers]) unless params[:followers].all?(&:blank?)
    video = video.includes(:event).where(event: params[:events]) unless params[:events].all?(&:blank?)
    video = video.includes(:videotype).where(videotype: params[:videotypes]) unless params[:videotypes].all?(&:blank?)
    video = video.includes(:song).where(:songs => {:genre => params[:genres] }).references(:songs) unless params[:genres].all?(&:blank?) 
    video = video.all if params[:leaders].all?(&:blank?) and params[:followers].all?(&:blank?) and params[:channels].all?(&:blank?) and params[:events].all?(&:blank?) and params[:videotypes].all?(&:blank?) and params[:genres].all?(&:blank?)
    @videos = video.where.not(leader: nil, follower: nil, song: nil).limit(100)
    end
    
  end

  