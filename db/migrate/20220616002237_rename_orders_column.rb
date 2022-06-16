class RenameOrdersColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :rest_flg, :display_flg
  end
end
