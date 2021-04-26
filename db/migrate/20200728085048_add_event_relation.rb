class AddEventRelation < ActiveRecord::Migration[6.0]
  def change
    add_reference :videos, :event, foreign_key: true
  end
end
