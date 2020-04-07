class CreateKinds < ActiveRecord::Migration[5.0]
  def change
    create_table :kinds do |t|
      t.string :kind
      t.integer :seats
      t.integer :price
      t.integer :color_id
      t.timestamps
    end
  end
end
