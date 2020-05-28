class CreateConnection2s < ActiveRecord::Migration[5.0]
  def change
    create_table :connection2s do |t|
      t.references :kind, foreign_key: true
      t.references :payment, foreign_key: true
      t.string :invalid_flag
      t.timestamps
    end
  end
end
