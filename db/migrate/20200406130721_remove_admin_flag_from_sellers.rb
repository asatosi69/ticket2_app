class RemoveAdminFlagFromSellers < ActiveRecord::Migration[5.0]
  def change
    remove_column :sellers, :admin_flag, :string
  end
end
