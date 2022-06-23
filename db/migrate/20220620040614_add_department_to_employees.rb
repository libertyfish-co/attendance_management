class AddDepartmentToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_reference :employees, :department, null: false, foreign_key: true
  end
end
