class RenameEmployeesColumn < ActiveRecord::Migration[6.0]
  def change
     rename_column :employees, :attribute, :proparties
  end
end
