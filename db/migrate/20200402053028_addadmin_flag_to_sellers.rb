class AddadminFlagToSellers < ActiveRecord::Migration[5.0]
  def change
      add_column :sellers, :admin_flag, :boolean, default: false, null: false
  end
end
