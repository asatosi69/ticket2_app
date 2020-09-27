class AddDefaultToStages < ActiveRecord::Migration[5.2]
  def change
       add_column :stages, :default, :boolean, default: false, null: false
  end
end
