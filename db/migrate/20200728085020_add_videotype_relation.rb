class AddVideotypeRelation < ActiveRecord::Migration[6.0]
  def up
    add_reference :videos, :videotype
  end

  def down
    add_column :videos, :videotype, :string
  end
end
