class CreatePatterns < ActiveRecord::Migration[6.0]
  def change
    create_table :patterns do |t|
      t.string :pattern_name
      t.date :base_date
      t.datetime :start_time
      t.datetime :end_time
      t.string :work_content
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
