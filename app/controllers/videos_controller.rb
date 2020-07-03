class VideosController < ApplicationController

  def index
    @video = Yt::Video.new id: 's6iptZdCcG0'
    @playlist = Yt::Playlist.new id:  'PLVpQEq02oKDh6u5QaHibFHWfsoVfYrZuB'
  end


end
