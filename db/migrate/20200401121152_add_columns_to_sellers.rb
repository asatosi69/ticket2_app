class AddColumnsToSellers < ActiveRecord::Migration[5.0]
  def change
    add_column :sellers, :admin_flag, :string
    add_column :sellers, :sellername, :string
  end
end
