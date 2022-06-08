class CreateAttendanceDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :attendance_details do |t|
      t.references :attendance, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.references :work, null: false, foreign_key: true
      t.string :work_time

      t.timestamps
    end
  end
end
