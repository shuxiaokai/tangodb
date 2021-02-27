class VideosController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_video, only: %i[show edit]
  before_action :filter_videos, only: %i[filter index]

  NUMBER_OF_VIDEOS_PER_PAGE = 120

  helper_method :sort_column, :sort_direction

  def index; end

  def filter
    render json: {
      genre: @genres,
      leader: @leaders,
      follower: @followers,
      orchestra: @orchestras,
      video: render_to_string(partial: 'videos/index/videos', layout: false)
    }
  end

  def show
    @videos_total = Video.all.where(hidden: false).size
    videos = if Video.where(song_id: @video.song_id).size > 3
               Video.where(song_id: @video.song_id)
             else
               Video.where(channel_id: @video.channel_id)
             end

    @recommended_videos = videos.where(hidden: false)
                                .where.not(youtube_id: @video.youtube_id)
                                .order('popularity DESC')
                                .limit(3)
    @video.clicked!
  end

  def edit
    @video = Video.find_by(id: params[:id])
  end

  def update
    @video = Video.find_by(id: params[:id])
    @video.update(video_params)
    redirect_to watch_path(v: @video.youtube_id)
  end

  private

  def filter_videos
    @videos_total = Video.all.where(hidden: false).size
    @videos = Video.where(hidden: false)
                   .includes(:leader, :follower, :channel, :song, :event)
                   .order(sort_column + ' ' + sort_direction)
                   .filter_videos(filtering_params)

    @videos_paginated = @videos.paginate(page, NUMBER_OF_VIDEOS_PER_PAGE)
    @videos_paginated = @videos_paginated.shuffle if filtering_params.blank?

    @current_search = params[:query]
    @videos_paginated_size = @videos_paginated.size * (@page + 1)

    @genres = @videos.joins(:song).pluck('songs.genre').uniq.compact.sort.map(&:titleize).uniq.map do |text|
      { text: text }
    end

    @leaders = @videos.joins(:leader).pluck('leaders.name',
                                            'leaders.id').uniq(&:last).sort_by(&:first).map do |text, id|
      { text: text.titleize, value: id }
    end
    @followers = @videos.joins(:follower).pluck('followers.name',
                                                'followers.id').uniq(&:last).sort_by(&:first).map do |text, id|
      { text: text.titleize, value: id }
    end

    @orchestras = @videos.joins(:song).pluck('songs.artist').uniq.compact.sort.map(&:titleize).map do |text|
      { text: text }
    end

    @genres = [{ text: '', value: '' }] + @genres
    @leaders = [{ text: '', value: '' }] + @leaders
    @followers = [{ text: '', value: '' }] + @followers
    @orchestras = [{ text: '', value: '' }] + @orchestras
  end

  def set_video
    @video = Video.find_by(youtube_id: params[:v])
  end

  def sort_column
    acceptable_cols = ['songs.title',
                       'songs.artist',
                       'songs.genre',
                       'leaders.name',
                       'followers.name',
                       'channels.title',
                       'videos.upload_date',
                       'videos.view_count',
                       'songs.last_name_search',
                       'videos.popularity']

    acceptable_cols.include?(params[:sort]) ? params[:sort] : 'videos.popularity'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def page
    @page ||= params.permit(:page).fetch(:page, 0).to_i
  end

  def video_params
    params.require(:video).permit(:leader_id, :follower_id, :song_id, :event_id, :hidden)
  end

  def filtering_params
    params.permit(:leader, :follower, :channel, :genre, :orchestra, :song_id, :query, :hd, :event_id)
  end
end
