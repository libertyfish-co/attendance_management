class CreateDefpartments < ActiveRecord::Migration[6.0]
  def change
    create_table :defpartments do |t|
      t.references :corporation, null: false, foreign_key: true
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
