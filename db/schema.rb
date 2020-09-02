# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_02_025719) do

  create_table "colors", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "color_name"
    t.string "color_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_selected", default: false, null: false
  end

  create_table "connection2s", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "kind_id"
    t.integer "payment_id"
    t.boolean "invalid_flag", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind_id"], name: "index_connection2s_on_kind_id"
    t.index ["payment_id"], name: "index_connection2s_on_payment_id"
  end

  create_table "connection3s", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "payment_id"
    t.integer "stage_id"
    t.boolean "invalid_flag", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_id"], name: "index_connection3s_on_payment_id"
    t.index ["stage_id"], name: "index_connection3s_on_stage_id"
  end

  create_table "connections", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "stage_id"
    t.integer "kind_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "invalid_flag", default: false, null: false
    t.index ["kind_id"], name: "index_connections_on_kind_id"
    t.index ["stage_id"], name: "index_connections_on_stage_id"
  end

  create_table "kinds", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "kind"
    t.integer "seats"
    t.integer "price"
    t.integer "color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "end_flag", default: false, null: false
  end

  create_table "pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "notice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seller_id"
  end

  create_table "payments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "payment"
    t.string "abbreviation"
    t.integer "discount_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "discount_keyword"
  end

  create_table "sellers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "admin_flag", default: false, null: false
    t.string "url"
    t.string "subdomain"
    t.index ["confirmation_token"], name: "index_sellers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_sellers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_sellers_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_sellers_on_unlock_token", unique: true
  end

  create_table "stages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "stage"
    t.integer "total_seats"
    t.datetime "end_time"
    t.boolean "end_flag", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "remaining"
    t.datetime "start_time"
    t.datetime "stage_time"
  end

  create_table "tickets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "seller_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  add_foreign_key "connection2s", "kinds"
  add_foreign_key "connection2s", "payments"
  add_foreign_key "connection3s", "payments"
  add_foreign_key "connection3s", "stages"
  add_foreign_key "connections", "kinds"
  add_foreign_key "connections", "stages"
end
