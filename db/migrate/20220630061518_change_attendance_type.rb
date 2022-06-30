class ChangeAttendanceType < ActiveRecord::Migration[6.0]
  def change
    change_column :attendances, :break_time,        :float
    change_column :attendances, :operating_time,    :float
    change_column :attendances, :paid_time,         :float
    change_column :attendances, :special_paid_time, :float
    change_column :attendances, :deduction_time,    :float
  end
end
