class AddColumnsToTickets2 < ActiveRecord::Migration[5.0]
  def change
      add_column :tickets, :comment1, :text
      add_column :tickets, :comment2, :text
  end
end
