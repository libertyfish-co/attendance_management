class CreateBusinessCalendars < ActiveRecord::Migration[6.0]
  def change
    create_table :business_calendars do |t|
      t.references :corporation, null: false, foreign_key: true
      t.date :date
      t.string :attribute

      t.timestamps
    end
  end
end
