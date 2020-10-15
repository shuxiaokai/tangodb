class VideosFilterController < ApplicationController

  NUMBER_OF_VIDEOS_PER_PAGE = 25.freeze
  HERO_YOUTUBE_ID = 's6iptZdCcG0'.freeze

  helper_method :sort_column, :sort_direction

  def index
    @videos_sorted = Video.search(params[:q])
                          .includes(:song, :leader, :follower, :videotype, :event)
                          .references(:song, :leader, :follower, :videotype, :event)
                          .order(sort_column + " " + sort_direction)

    @videos_filtered = @videos_sorted
    # @videos_filtered = @videos_filtered.videotype(params[:videotype]) if params[:videotype].present?
    @videos_filtered = @videos_filtered.genre(videos_filter_params[:genre])
    # @videos_filtered = @videos_filtered.leader(params[:leader]) if params[:leader].present?
    # @videos_filtered = @videos_filtered.follower(params[:follower]) if params[:follower].present?
    # @videos_filtered = @videos_filtered.event(params[:event]) if params[:event].present?
    # @videos_filtered = @videos_filtered.channel(params[:channel]) if params[:channel].present?

    @videos_paginated = @videos_filtered.paginate( page, NUMBER_OF_VIDEOS_PER_PAGE )

  end

  private

  def videos_filter_params
    params.require('videos_filter').permit(genres:)
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
    @page ||= params.permit(:page).fetch(:page, 0).to_i
  end
end
