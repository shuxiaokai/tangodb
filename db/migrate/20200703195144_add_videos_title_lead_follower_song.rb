class AddVideosTitleLeadFollowerSong < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :title, :text
    add_column :videos, :leader, :string
    add_column :videos, :follower, :string
    add_column :videos, :song, :string
  end
end
