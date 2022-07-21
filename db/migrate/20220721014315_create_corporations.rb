class CreateCorporations < ActiveRecord::Migration[6.0]
  def change
    create_table :corporations do |t|
        t.string :name
        t.integer :time_unit
        t.integer :time_limit
    
          
        t.integer :scheduled_working_hours,  defalut: 480
        t.integer :regular_lines, defalut: 99
    
        t.timestamps
    end
  end
end
