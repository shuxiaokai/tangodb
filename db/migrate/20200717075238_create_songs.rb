class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :genre  null: false
      t.string :title  null: false
      t.string :artist null: false

      t.timestamps null: false
    end
  end
end
