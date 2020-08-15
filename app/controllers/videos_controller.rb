class VideosController < ApplicationController
  before_action :authenticate_user!, except:[:index]
  helper_method :sort_column, :sort_direction

  include Pagy::Backend

  def index
    @query = session[:query]
    @order_by = permitted_column_name(session[:order_by])
    @direction = permitted_direction(session[:direction])

    videos = Video.order(@order_by => @direction).where.not(leader: nil, follower: nil, song: nil)
    videos = videos.search(@query) if @query.present?
    page_count = (videos.count / Pagy::VARS[:items].to_f).ceil

    @page = (session[:page] || 1).to_i
    @page = page_count if @page > page_count
    @pagy, @videos = pagy(videos, page: @page)

    # if params[:search_by_keyword]
    #          @videos = Video.filter(params.slice(:leader_id, :follower_id, :channel, :song_id, :view_count, :upload_date, :genre, :videotype_id, :event_id))
    #                         .order(sort_column + " " + sort_direction)
    #                         .includes(:leader, :follower, :song, :videotype, :event)
    #                         .search_by_keyword(params[:search_by_keyword])
    #                         .where.not(leader: nil, follower: nil, song: nil)

    #   @pagy, @v_pagination = pagy(Video.filter(params.slice(:leader_id, :follower_id, :channel, :song_id, :view_count, :upload_date, :genre, :videotype_id, :event_id))
    #                                    .order(sort_column + " " + sort_direction)
    #                                    .includes(:leader, :follower, :song, :videotype, :event)
    #                                    .search_by_keyword(params[:search_by_keyword])
    #                                    .where.not(leader: nil, follower: nil, song: nil), items: 100)
    # else
    #          @videos = Video.filter(params.slice(:leader_id, :follower_id, :channel, :genre, :videotype_id, :event_id))
    #                         .includes(:leader, :follower, :song, :videotype, :event)
    #                         .order(sort_column + " " + sort_direction)
    #                         .where.not(leader: nil, follower: nil, song: nil)
                            
    #   @pagy, @v_pagination = pagy(Video.filter(params.slice(:leader_id, :follower_id, :channel, :genre, :videotype_id, :event_id))
    #                                     .includes(:leader, :follower, :song, :videotype, :event)
    #                                     .order(sort_column + " " + sort_direction)
    #                                     .where.not(leader: nil, follower: nil, song: nil), items: 100)
    # end


    # @videos = Video.includes(:leader, :follower, :song, :videotype, :event)
    #                .where.not(leader: nil, follower: nil, song: nil).limit(1000)
    # @leaders = @videos.includes(:leader).map(&:leader).compact.uniq.sort
    # @followers = @videos.includes(:follower).map(&:follower).compact.uniq.sort
    # @channels = @videos.pluck(:channel).compact.uniq.sort
    # @genres = @videos.includes(:song).pluck(:genre).compact.uniq.sort
    # @songs = @videos.includes(:song).map(&:song).compact.uniq.sort
    # @events = @videos.includes(:event).map(&:event).compact.uniq.sort
    # @videotypes = @videos.includes(:videotype).map(&:videotype).compact.uniq
    
  end

  def show
    @query = session[:query]
    @order_by = permitted_column_name(session[:order_by])
    @direction = permitted_direction(session[:direction])

    videos = Video.order(@order_by => @direction)
    videos = videos.search(@query) if @query.present?
    page_count = (videos.count / Pagy::VARS[:items].to_f).ceil

    @page = (session[:page] || 1).to_i
    @page = page_count if @page > page_count
    @pagy, @videos = pagy(videos, page: @page)
  end


  def search
  
    @videos = Video.all.search_by_keyword(params[:search_by_keyword])

  end

private

  # def sort_column
  #   Video.column_names.include?(params[:sort]) ? params[:sort] : "upload_date"
  # end

  # def sort_direction
  #   %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  # end

  def permitted_column_name(column_name)
    %w[channel view_count  upload_date].find { |permitted| column_name == permitted } || "channel"
  end

  def permitted_direction(direction)
    %w[asc desc].find { |permitted| direction == permitted } || "asc"
  end

end