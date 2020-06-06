class AddColumnsToTickets3 < ActiveRecord::Migration[5.0]
  def change
      add_column :tickets, :stage_id, :integer
      add_column :tickets, :kind_id, :integer
      add_column :tickets, :payment_id, :integer
      add_column :tickets, :count, :integer
      add_column :tickets, :buyer_name, :string
      add_column :tickets, :buyer_furigana, :string
      add_column :tickets, :buyer_mail, :string
  end
end
