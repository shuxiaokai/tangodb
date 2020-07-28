class AddEventRelation < ActiveRecord::Migration[6.0]
  def up
    add_reference :videos, :event
  end

  def down
    add_column :videos, :event, :string
  end
end
