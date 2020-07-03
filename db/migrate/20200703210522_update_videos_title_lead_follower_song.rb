class UpdateVideosTitleLeadFollowerSong < ActiveRecord::Migration[6.0]
  def change
    change_column :videos, :title, :text, null: false
    change_column :videos, :leader, :string, null: false
    change_column :videos, :follower, :string, null: false
    change_column :videos, :song, :string, null: false
    change_column :videos, :youtube_id, :string, null: false
  end
end
