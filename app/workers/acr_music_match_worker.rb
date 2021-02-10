class AcrMusicMatchWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: false

  def perform(youtube_id)
    Video.acr_music_match(youtube_id)
  end
end
