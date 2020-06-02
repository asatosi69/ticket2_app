class Addkeywordtopayment < ActiveRecord::Migration[5.2]
  def change
      add_column :payments, :discount_keyword, :string
  end
end
