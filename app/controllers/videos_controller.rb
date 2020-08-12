class VideosController < ApplicationController
  before_action :authenticate_user!, except:[:index]
  helper_method :sort_column, :sort_direction

  #include Pagy::Backend

  def index
    
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



    @leaders = Video.all.joins(:leader).pluck('leaders.name').uniq
    @followers = Video.all.joins(:follower).pluck('followers.name').uniq
    @channels = Video.all.order(:channel).pluck(:channel).uniq
    @songs = Video.all.joins(:song).pluck('songs.genre').uniq
    @events = Video.all.joins(:event).pluck('events.name').uniq
    @videotypes = Video.all.joins(:videotype).pluck('name').uniq
    @videos = Video.all.where.not(leader: nil, follower: nil, song: nil).limit(100)
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