class AddStageTimeToStages < ActiveRecord::Migration[5.0]
  def change
      add_column :stages, :stage_time, :datetime
  end
end
