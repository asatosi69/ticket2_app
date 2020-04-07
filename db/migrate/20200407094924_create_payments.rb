class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :payment
      t.string :abbreviation
      t.integer :discount_rate
      t.timestamps
    end
  end
end
