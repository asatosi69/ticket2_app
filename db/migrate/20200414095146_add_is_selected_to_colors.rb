class AddIsSelectedToColors < ActiveRecord::Migration[5.0]
  def change
      add_column :colors, :is_selected, :boolean, default: false, null: false
  end
end
