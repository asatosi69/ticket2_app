class AddColumnTickets < ActiveRecord::Migration[5.2]
  def change
      add_column :tickets, :tel, :string
  end
end
