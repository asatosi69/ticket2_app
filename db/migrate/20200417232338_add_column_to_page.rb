class AddColumnToPage < ActiveRecord::Migration[5.0]
  def change
      add_column :pages, :seller_id, :integer
  end
end
