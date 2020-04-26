class RemoveUrlFromSellers < ActiveRecord::Migration[5.2]
  def change
    remove_column :sellers, :url, :string
  end
end
