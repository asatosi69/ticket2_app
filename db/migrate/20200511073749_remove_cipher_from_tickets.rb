class RemoveCipherFromTickets < ActiveRecord::Migration[5.2]
  def change
    remove_column :tickets, :cipher, :string
  end
end
