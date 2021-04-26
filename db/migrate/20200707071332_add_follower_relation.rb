class AddFollowerRelation < ActiveRecord::Migration[6.0]
  def up
    remove_column :videos, :follower
    add_reference :videos, :follower
  end

  def down
    remove_reference :videos, :follower
    add_column :videos, :follower, :string
  end
end
