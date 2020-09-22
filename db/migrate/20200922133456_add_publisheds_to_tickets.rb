class AddPublishedsToTickets < ActiveRecord::Migration[5.2]
  def change
      add_column :tickets, :published, :boolean, default: false, null: false
  end
end
