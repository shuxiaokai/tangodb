class VideosController < ApplicationController
  helper_method :sort_column, :sort_direction

  include Pagy::Backend

  def index

    video = Video
    # video = video.where(channel: params[:channel]).order(sort_column + " " + sort_direction).where.not(leader: nil, follower: nil, song: nil) unless params[:channel].blank?
    # video = video.includes(:leader).where(leader_id: params[:leader_id]).order(sort_column + " " + sort_direction).where.not(leader: nil, follower: nil, song: nil) unless params[:leader_id].blank?
    # video = video.includes(:follower).where(follower_id: params[:follower_id]).order(sort_column + " " + sort_direction).where.not(leader: nil, follower: nil, song: nil) unless params[:follower_id].blank?
    # video = video.includes(:event).where(event_id: params[:event_id]).order(sort_column + " " + sort_direction).where.not(leader: nil, follower: nil, song: nil) unless params[:event_id].blank?
    # video = video.includes(:videotype).where(videotype_id: params[:videotype_id]).order(sort_column + " " + sort_direction).where.not(leader: nil, follower: nil, song: nil) unless params[:videotype_id].blank?
    # video = video.includes(:song).where(:songs => {:genre => params[:genre] }).references(:songs).order(sort_column + " " + sort_direction).where.not(leader: nil, follower: nil, song: nil) unless params[:genre].blank?
    video = video.includes(:song, :leader, :follower, :event, :videotype).order(sort_column + " " + sort_direction).search(params[:query]) if params[:query].present?
    video = video.all.includes(:song, :leader, :follower, :event, :videotype).order(sort_column + " " + sort_direction).where.not(leader: nil, follower: nil, song: nil)
    
    @pagy, @videos = pagy(video, items: 100)

     @videotypes  = video.includes(:videotype).map(&:videotype).compact.uniq
     @genres      = video.includes(:song).pluck(:genre).compact.uniq.sort
     @leaders     = video.includes(:leader).map(&:leader).compact.uniq.sort
     @followers   = video.includes(:follower).map(&:follower).compact.uniq.sort
     @events      = video.includes(:event).map(&:event).compact.uniq.sort
     @channels    = video.pluck(:channel).compact.uniq.sort
     @songs       = video.includes(:song).map(&:song).compact.uniq.sort
  end

private

  def sort_column
    acceptable_cols = ["songs.artist", "songs.genre","youtube_id","sort","direction","leader_id","follower_id","channel","upload_date","view_count","song_id","songs.artist", "songs.genre", "videotype_id", "event_id", "query", "page"]
    acceptable_cols.include?(params[:sort]) ? params[:sort] : "upload_date"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  # def permitted_column_name(column_name)
  #   %w[song_id follower_id leader_id channel song_genre event_id videotype_id view_count upload_date].find { |permitted| column_name == permitted } || "channel"
  # end

  # def permitted_direction(direction)
  #   %w[asc desc].find { |permitted| direction == permitted } || "asc"
  # end

end