class VideosController < ApplicationController

  def index
    @videos = Video.includes(:leader, :follower).order(params[:sort])
    @leaders = Leader.all
    @followers = Follower.all
  end
end

private

def sort_column
  Video.column_names.include?(params[:sort]) ? params[:sort] : "name"
end

def sort_direction
  %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
end