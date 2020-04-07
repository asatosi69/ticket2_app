class CreateStages < ActiveRecord::Migration[5.0]
  def change
    create_table :stages do |t|
      t.string :stage
      t.integer :total_seats
      t.datetime :end_time
      t.boolean :end_flag, default: false, null: false
      t.timestamps
    end
  end
end
