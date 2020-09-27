class RemoveDefaultToPayments < ActiveRecord::Migration[5.2]
  def change
      remove_column :payments, :default, :boolean, default: false, null: false
  end
end
