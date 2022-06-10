class CreatePatternDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :pattern_details do |t|
      t.references :order, null: false, foreign_key: true
      t.references :work, null: false, foreign_key: true
      t.references :pattern, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :work_content

      t.timestamps
    end
  end
end
