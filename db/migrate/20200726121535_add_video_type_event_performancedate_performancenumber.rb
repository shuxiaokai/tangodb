class AddVideoTypeEventPerformancedatePerformancenumber < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :type, :string
    add_column :videos, :performance_date, :datetime
    add_column :videos, :performance_number, :int
    add_column :videos, :performance_total, :int
    
  end
end
