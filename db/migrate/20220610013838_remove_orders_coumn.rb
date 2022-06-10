class RemoveOrdersCoumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :start_time, :datetime
    remove_column :orders, :end_time, :datetime
  end
end
