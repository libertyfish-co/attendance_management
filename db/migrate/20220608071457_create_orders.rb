class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :corporation, null: false, foreign_key: true
      t.string :code
      t.string :name
      t.boolean :time_flg
      t.boolean :show_flg
      t.boolean :paid_digestion_flg
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
