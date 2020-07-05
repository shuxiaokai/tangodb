class CreateLeaders < ActiveRecord::Migration[6.0]
  def change
    create_table :leaders do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps null: false
    end

    add_index :leaders, %i[first_name last_name], unique: true
  end
end
