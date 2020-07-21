class CreateDancers < ActiveRecord::Migration[6.0]
  def change
    create_table :dancers do |t|
      t.string :first_dancer
      t.string :second_dancer
      t.string :title

      t.timestamps
    end
  end
end
