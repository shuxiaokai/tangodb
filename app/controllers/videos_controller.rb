class VideosController < ApplicationController

  helper_method :sort_column, :sort_directions

  def index
    @videos    = Video.includes(:leader, :follower).order(sort_column + " " + sort_direction)
    @leaders   = Leader.all
    @followers = Follower.all
  end

  def show
    @video.id = Video.find(params[:id])
  end

private

  def sort_column
    Video.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end