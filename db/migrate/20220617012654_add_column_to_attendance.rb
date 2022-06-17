class AddColumnToAttendance < ActiveRecord::Migration[6.0]
  def change
    add_column :attendances, :break_time, :integer
    add_column :attendances, :operating_time, :integer
    add_column :attendances, :paid_time, :integer
    add_column :attendances, :special_paid_time, :integer
    add_column :attendances, :deduction_time, :integer
    add_column :attendances, :consistency_flg, :boolean, defalut: false
    add_column :attendances, :approval_flg, :boolean, defalut: false
    add_column :attendances, :lock_flg, :boolean, defalut: false
  end
end
