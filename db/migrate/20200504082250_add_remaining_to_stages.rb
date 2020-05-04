class AddRemainingToStages < ActiveRecord::Migration[5.2]
  def change
    add_column :stages, :remaining, :integer
  end
end
