class AddStartTimeToStages < ActiveRecord::Migration[5.2]
  def change
      add_columns :stages, :start_time, :datetime
  end
end
