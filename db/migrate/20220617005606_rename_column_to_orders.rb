class RenameColumnToOrders < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :time_flg, :itemized_time
    remove_column :orders, :paid_digestion_flg, :boolean
    add_column :orders, :flg, :integer
  end
end
