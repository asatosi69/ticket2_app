class AddDefaultToPayments2 < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :default, :boolean, default: false, null: false
  end
end
