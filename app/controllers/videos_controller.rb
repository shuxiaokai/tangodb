class VideosController < ApplicationController

  helper_method :sort_column, :sort_direction

  include Pagy::Backend

  def index
    
    if params[:search_by_keyword]
             @videos = Video.filter(params.slice(:leader_id, :follower_id, :channel, :song_id, :view_count, :upload_date)).order(sort_column + " " + sort_direction).includes(:leader, :follower, :song).search_by_keyword(params[:search_by_keyword]).where.not(leader: nil, follower: nil, song: nil)
      @pagy, @v_pagination = pagy(Video.filter(params.slice(:leader_id, :follower_id, :channel, :song_id, :view_count, :upload_date)).order(sort_column + " " + sort_direction).includes(:leader, :follower, :song).search_by_keyword(params[:search_by_keyword]).where.not(leader: nil, follower: nil, song: nil), items: 100)
    else
             @videos = Video.filter(params.slice(:leader_id, :follower_id, :channel)).includes(:leader, :follower, :song).order(sort_column + " " + sort_direction).where.not(leader: nil, follower: nil, song: nil)
      @pagy, @v_pagination = pagy(Video.filter(params.slice(:leader_id, :follower_id, :channel)).includes(:leader, :follower, :song).order(sort_column + " " + sort_direction).where.not(leader: nil, follower: nil, song: nil), items: 100)
    end
      
  end

  def search
  
    @videos = Video.all.search_by_keyword(params[:search_by_keyword])

  end

private


  def sort_column
    Video.column_names.include?(params[:sort]) ? params[:sort] : "upload_date"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end