class AddLeaderRelation < ActiveRecord::Migration[6.0]
  def up
    remove_column :videos, :leader
    add_reference :videos, :leader
  end

  def down
    remove_reference :videos, :leader
    add_column :videos, :leader, :string
  end
end
