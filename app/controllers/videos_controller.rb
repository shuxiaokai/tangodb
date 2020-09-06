class VideosController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index

    # Feeds default url to iframe if a params link isn't selected

    if params[:youtube_id].blank?
      @active_video_url = 's6iptZdCcG0'
      @active_video = Video.find_by(youtube_id: @active_video_url)
    else
      @active_video_url = params[:youtube_id]
      @active_video = Video.find_by(youtube_id: params[:youtube_id])
    end

    @videos = Video.includes(:song, :leader, :follower)
            .order(sort_column + " " + sort_direction)
            .where.not(leader: nil, follower: nil, song: nil)

    @videos = @videos.order(sort_column + " " + sort_direction).search(params[:query]) if params[:query].present?

    @videos = @videos.limit(2).offset(2 * page)
  end

private

  def sort_column
    acceptable_cols = ["songs.artist",
                        "songs.genre",
                        "youtube_id",
                        "sort",
                        "direction",
                        "leader_id",
                        "follower_id",
                        "channel",
                        "upload_date",
                        "view_count",
                        "song_id",
                        "songs.artist",
                        "songs.genre",
                        "videotype_id",
                        "event_id",
                        "query",
                        "page"]
    acceptable_cols.include?(params[:sort]) ? params[:sort] : "upload_date"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def page
    params.permit(:page).fetch(:page, default: 0).to_i
  end
end
