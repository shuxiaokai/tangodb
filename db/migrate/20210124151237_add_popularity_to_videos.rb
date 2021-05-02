class AddPopularityToVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :popularity, :int, default: 0
  end
end