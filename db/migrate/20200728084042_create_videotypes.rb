class CreateVideotypes < ActiveRecord::Migration[6.0]
  def change
    create_table :videotypes do |t|
      t.string :name, null: false, unique: true
      t.string :related_keywords
    end
  end
end
