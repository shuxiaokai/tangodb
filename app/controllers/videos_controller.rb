class VideosController < ApplicationController
  helper_method :sort_column, :sort_direction
  include Pagy::Backend
  def index
    
    if params[:search_by_keyword]
             @videos = Video.filter(params.slice(:leader_id, :follower_id, :channel)).includes(:leader, :follower).search_by_keyword(params[:search_by_keyword]).order(sort_column + " " + sort_direction)
      @pagy, @v_pagination = pagy(Video.filter(params.slice(:leader_id, :follower_id, :channel)).includes(:leader, :follower).search_by_keyword(params[:search_by_keyword]).order(sort_column + " " + sort_direction), items: 100)
    else
             @videos = Video.filter(params.slice(:leader_id, :follower_id, :channel)).includes(:leader, :follower).order(sort_column + " " + sort_direction)
      @pagy, @v_pagination = pagy(Video.filter(params.slice(:leader_id, :follower_id, :channel)).includes(:leader, :follower).order(sort_column + " " + sort_direction), items: 100)
    end
      
  end

  def search
  
    @videos = Video.all.search_by_keyword(params[:search_by_keyword])

  end

private

    # A list of the param names that can be used for filtering the Product list
  def filtering_params(params)
    params.slice(:with_leader, :with_follower, :with_channel)
  end

  def sort_column
    Video.column_names.include?(params[:sort]) ? params[:sort] : "view_count"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end