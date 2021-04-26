class AddIndexesToVideo < ActiveRecord::Migration[6.1]
  def change
    add_index :videos, :youtube_artist
    add_index :videos, :youtube_song
    add_index :videos, :spotify_track_name
    add_index :videos, :spotify_artist_name
    add_index :videos, :acr_cloud_track_name
    add_index :videos, :acr_cloud_artist_name
  end
end
