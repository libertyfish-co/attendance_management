class AddIndexToAttendances < ActiveRecord::Migration[6.0]
  def change
    add_index :attendances, [:employee_id, :base_date], unique: true
  end
end
