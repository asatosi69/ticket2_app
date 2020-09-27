class RemoveDefaultToKinds < ActiveRecord::Migration[5.2]
  def change
      remove_column :kinds, :default, :boolean, default: false, null: false
  end
end
