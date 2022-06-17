class RemoveColumnToAttendanceDetails < ActiveRecord::Migration[6.0]
  def change
    remove_column :attendance_details, :work_time, :string
    add_column :attendance_details, :work_time, :integer
  end
end
