class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.references :corporation, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :rest_time
      t.string :work_content

      t.timestamps
    end
  end
end
