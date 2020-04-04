class RenameToColumnToTickets3 < ActiveRecord::Migration[5.0]
  def change
      rename_column :tickets, :seller_id, :sellername
  end
end
