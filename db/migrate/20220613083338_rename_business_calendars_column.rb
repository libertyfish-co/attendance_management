class RenameBusinessCalendarsColumn < ActiveRecord::Migration[6.0]
  def change
     rename_column :business_calendars, :attribute, :proparties
  end
end
