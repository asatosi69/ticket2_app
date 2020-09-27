class CreateDefaults < ActiveRecord::Migration[5.2]
  def change
    create_table :defaults do |t|
      t.integer "stage_id"
      t.integer "kind_id"
      t.integer "payment_id"
      t.integer "count"
      t.timestamps
    end
  end
end
