class CreateDeletes < ActiveRecord::Migration[5.2]
  def change
    create_table :deletes do |t|
        t.integer "seller_id"
        t.text "comment1"
        t.text "comment2"
        t.boolean "visited_flag", default: true, null: false
        t.boolean "enquete_flag", default: false, null: false
        t.integer "stage_id"
        t.integer "kind_id"
        t.integer "payment_id"
        t.integer "count"
        t.string "buyer_name"
        t.string "buyer_furigana"
        t.string "buyer_mail"
        t.string "tel"
        t.boolean "published", default: false, null: false
        t.string "reviser"
      t.timestamps
    end
  end
end
