class ChangeAttendanceDetailColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :attendance_details, :start_time, :datetime
    add_column :attendance_details, :end_time, :datetime
    add_column :attendance_details, :work_content, :string
  end
end
