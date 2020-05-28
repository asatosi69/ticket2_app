class CreateConnection3s < ActiveRecord::Migration[5.0]
  def change
    create_table :connection3s do |t|
      t.references :payment, foreign_key: true
      t.references :stage, foreign_key: true
      t.string :invalid_flag
      t.timestamps
    end
  end
end
