class AddColumnSellers < ActiveRecord::Migration[5.2]
  def change
      add_column :sellers, :url, :string
  end
end
