class VideosFilterController < ApplicationController
    def index
      @videos = Video.where(channel: params[:channels]).order(:channel)
                .where.not(leader: nil, follower: nil, song: nil).limit(100)
    end
  end