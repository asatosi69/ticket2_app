class ChangeDataTypeOfTickets < ActiveRecord::Migration[5.0]
  def change
      change_column :tickets, :seller_id, :string
  end
end
