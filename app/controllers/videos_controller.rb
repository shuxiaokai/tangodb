class VideosController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @videos    = Video.includes(:leader, :follower).order(sort_column + " " + sort_direction).limit(100)
    @leaders   = Leader.all
    @followers = Follower.all
  end

  def filter_params(relation)
    return relation unless filter_params.any?

  relation.where(filter_params)
  end


private

  def sort_column
    Video.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end