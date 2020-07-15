class VideosController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    #@follower_id = params[:follower_id]
    #@leader_id = params[:leader_id]
    #@videos    = Video.includes(:leader, :follower).order(sort_column + " " + sort_direction).limit(1000)
    @videos = Video.filter(params.slice(:leader_id, :follower_id)).order(sort_column + " " + sort_direction).limit(3000)
    @leaders   = Leader.all
    @followers = Follower.all
  end

private

    # A list of the param names that can be used for filtering the Product list
  def filtering_params(params)
    params.slice(:with_leader, :with_follower)
  end

  def sort_column
    Video.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end