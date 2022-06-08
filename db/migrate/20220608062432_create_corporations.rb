class CreateCorporations < ActiveRecord::Migration[6.0]
  def change
    create_table :corporations do |t|
      t.string :name
      t.integer :time_unit
      t.integer :time_limit

      t.timestamps
    end
  end
end
