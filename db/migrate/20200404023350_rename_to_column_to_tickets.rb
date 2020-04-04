class RenameToColumnToTickets < ActiveRecord::Migration[5.0]
  def change
      rename_column :tickets, :name, :sellername
  end
end
