class AddStartTimeToStages < ActiveRecord::Migration[5.2]
  def change
      add_column :stages, :start_time, :datetime
  end
end
