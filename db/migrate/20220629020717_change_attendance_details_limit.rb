class ChangeAttendanceDetailsLimit < ActiveRecord::Migration[6.0]
  def change
    change_column_null :attendance_details, :order_id, true
    change_column_null :attendance_details, :work_id, true
  end
end
