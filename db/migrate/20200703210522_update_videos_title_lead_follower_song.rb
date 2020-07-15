class UpdateVideosTitleLeadFollowerSong < ActiveRecord::Migration[6.0]
  def change
    change_column :videos, :title, :text
    change_column :videos, :leader, :string
    change_column :videos, :follower, :string
    change_column :videos, :song, :string
    change_column :videos, :youtube_id, :string
  end
end
