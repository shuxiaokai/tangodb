class VideosController < ApplicationController
  # before_action :authenticate_user!

  NUMBER_OF_VIDEOS_PER_PAGE = 25.freeze
  HERO_YOUTUBE_ID = 's6iptZdCcG0'.freeze

  helper_method :sort_column, :sort_direction

  def index
    @active_video = Video.find_by(youtube_id: active_youtube_id)
 
    @videos_sorted = Video.search(params[:q])
                          .includes(:song, :leader, :follower, :videotype, :event)
                          .references(:song, :leader, :follower, :videotype, :event)
                          .order(sort_column + " " + sort_direction)
    
    @videos_paginated = @videos_sorted.paginate(page: page, per_page: NUMBER_OF_VIDEOS_PER_PAGE )
  end

private

  def active_youtube_id
    @active_youtube_id ||= params[:youtube_id] || HERO_YOUTUBE_ID
  end

  def sort_column
    acceptable_cols = [ "songs.title",
                        "songs.artist",
                        "songs.genre",
                        "leaders.name",
                        "followers.name",
                        "channel",
                        "upload_date",
                        "view_count",
                        "videotypes.name",
                        "events.name"]
    acceptable_cols.include?(params[:sort]) ? params[:sort] : "upload_date"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def page
    @page ||= params.permit(:page).fetch(:page, 1).to_i
  end
end
