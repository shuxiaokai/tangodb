class VideosController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @videos = Video.filter(params.slice(:leader_id, :follower_id, :channel)).search(params[:search_keyword]).order(sort_column + " " + sort_direction).limit(2000)
    @leaders   = Leader.all
    @followers = Follower.all
  end

  def search
    @videos = Video.search(params[:search_keyword])
  end

private

    # A list of the param names that can be used for filtering the Product list
  def filtering_params(params)
    params.slice(:with_leader, :with_follower, :with_channel)
  end

  def sort_column
    Video.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end