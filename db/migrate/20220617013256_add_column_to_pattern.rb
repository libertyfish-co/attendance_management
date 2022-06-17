class AddColumnToPattern < ActiveRecord::Migration[6.0]
  def change
    add_column :patterns, :break_time, :integer
    add_column :patterns, :operating_time, :integer
    add_column :patterns, :paid_time, :integer
    add_column :patterns, :special_paid_time, :integer
    add_column :patterns, :deduction_time, :integer
  end
end
