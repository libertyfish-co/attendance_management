class CreateAttendanceDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :attendance_details do |t|
      t.references :attendance, null: false, foreign_key: true
      t.references :order, null: true, foreign_key: true
      t.references :work, null: true, foreign_key: true
      t.datetime   :start_time
      t.datetime   :end_time
      t.string     :work_content
      t.integer    :work_time
     
      t.timestamps
    end
  end
end
