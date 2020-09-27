class RemoveDefaultfromStage < ActiveRecord::Migration[5.2]
  def change
      remove_column :stages, :default, :boolean, default: false, null: false
  end
end
