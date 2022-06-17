class AddWorkTimeToPatternDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :pattern_details, :work_time, :integer
  end
end
