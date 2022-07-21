class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :corporation, null: false, foreign_key: true
      t.string   :code
      t.string   :name
      t.integer  :itemized_time
      t.integer  :display_flg
      t.date     :expiration_date
      t.integer  :flg
      
    


      t.timestamps
    end
  end
end
