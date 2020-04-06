class RemoveSellernameFromSellers < ActiveRecord::Migration[5.0]
  def change
    remove_column :sellers, :sellername, :string
  end
end
