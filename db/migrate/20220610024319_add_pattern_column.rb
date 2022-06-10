class AddPatternColumn < ActiveRecord::Migration[6.0]
  def change
     add_column :patterns, :default_flg, :boolean
  end
end
