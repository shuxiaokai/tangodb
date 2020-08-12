class VideosFilterController < ApplicationController
    def index
      @videos = Video.where(channel: params[:channels]).order(:channel).limit(100)
    end
  end