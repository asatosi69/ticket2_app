class ChangeDataTitleToSeller < ActiveRecord::Migration[5.0]
  def change
      change_column :tickets, :seller_id, :integer
  end
end
