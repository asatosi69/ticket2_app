class RenameToColumnToTickets2 < ActiveRecord::Migration[5.0]
  def change
      rename_column :tickets, :sellername, :seller_id
  end
end
