class AddEncryptionToTicket < ActiveRecord::Migration[5.2]
  def change
      add_column :tickets, :cipher, :string
  end
end
