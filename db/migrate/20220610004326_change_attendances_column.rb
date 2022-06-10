class ChangeAttendancesColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :attendances, :rest_time, :datetime
    remove_column :attendances, :corporation_id, :bigint
    add_column :attendances, :base_date, :date
  end
end
