class ChangeAttendanceDetailsLimit < ActiveRecord::Migration[6.0]
  def change
    change_column_null :attendance_details, :order_id, false
    change_column_null :attendance_details, :work_id, false
  end
end
