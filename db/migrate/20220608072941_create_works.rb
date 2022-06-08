class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.references :corporation, null: false, foreign_key: true
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
