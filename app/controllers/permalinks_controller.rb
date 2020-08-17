class PermalinksController < ApplicationController
    def show
    @channels = Video.select(:channel).distinct.order(:channel).map(&:channel)
    @videos   = Video.channel(params[:channel])
  end
end