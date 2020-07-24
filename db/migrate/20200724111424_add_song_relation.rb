class AddSongRelation < ActiveRecord::Migration[6.0]
  def up
    remove_column :videos, :song
    add_reference :videos, :song
  end

  def down
    remove_reference :videos, :song
    add_column :videos, :song, :string
  end
end
