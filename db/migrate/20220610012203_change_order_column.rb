class ChangeOrderColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :time_flg, :boolean
    remove_column :orders, :show_flg, :boolean
    add_column :orders, :time_flg, :integer
    add_column :orders, :rest_flg, :integer
    add_column :orders, :expiration_date, :date
  end
end
