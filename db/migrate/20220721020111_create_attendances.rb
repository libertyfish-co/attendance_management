class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.references :employee, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :work_content
      t.date :base_date
      t.integer :break_time
      t.integer :operating_time
      t.integer :paid_time
      t.integer :special_paid_time
      t.integer :deduction_time
      t.boolean :consistency_flg, defalut: false
      t.boolean :approval_flg, defalut: false
      t.boolean :lock_flg, defalut: false

      t.timestamps
    end
    add_index :attendances, [:employee_id, :base_date], unique: true, name:'attendances_employee_base_date_index'
    
  end
end
