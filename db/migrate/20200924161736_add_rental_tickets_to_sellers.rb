class AddRentalTicketsToSellers < ActiveRecord::Migration[5.2]
  def change
    add_column :sellers, :Rental_Tickets, :integer, default: 0
  end
end
