class AddRentalTicketsToSellers2 < ActiveRecord::Migration[5.2]
  def change
      remove_column :sellers, :Rental_Tickets, :integer, default: 0
      add_column :sellers, :rental_tickets, :integer, default: 0
  end
end
