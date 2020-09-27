class AddDefaultToKind2 < ActiveRecord::Migration[5.2]
  def change
             add_column :kinds, :default, :boolean, default: false, null: false
  end
end
