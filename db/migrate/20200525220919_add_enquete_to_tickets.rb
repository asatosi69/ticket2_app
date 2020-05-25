class AddEnqueteToTickets < ActiveRecord::Migration[5.2]
  def change
      add_column :tickets, :enquete_flag, :boolean, default: false, null: false
  end
end
