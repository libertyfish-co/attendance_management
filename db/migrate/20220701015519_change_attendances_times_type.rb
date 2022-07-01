class ChangeAttendancesTimesType < ActiveRecord::Migration[6.0]
  def change
    change_column :attendances, :break_time,        :integer
    change_column :attendances, :operating_time,    :integer
    change_column :attendances, :paid_time,         :integer
    change_column :attendances, :special_paid_time, :integer
    change_column :attendances, :deduction_time,    :integer
  end
end
