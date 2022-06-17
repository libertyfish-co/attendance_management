class AddColumnToCorporations < ActiveRecord::Migration[6.0]
  def change
    add_column :corporations, :scheduled_working_hours, :integer, defalut: 480
    add_column :corporations, :regular_lines, :integer, defalut: 99
  end
end
