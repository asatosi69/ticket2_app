class AddRevisersToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :reviser, :string
  end
end
