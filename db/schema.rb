# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_25_044832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.string "content_type"
    t.integer "content_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_type", "content_id"], name: "index_messages_on_content_type_and_content_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", default: ""
    t.integer "tracks_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_sites_on_name"
  end

  create_table "steps", force: :cascade do |t|
    t.string "act", null: false
    t.string "value"
    t.bigint "message_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id"], name: "index_steps_on_message_id"
  end

  create_table "text_messages", force: :cascade do |t|
    t.bigint "messenger_user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "profile_pic_url"
    t.string "timezone"
    t.string "locale"
    t.string "source"
    t.string "last_seen"
    t.string "signed_up"
    t.string "sessions"
    t.string "last_visited_block_name"
    t.string "last_visited_block_id"
    t.string "last_clicked_button_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "code", null: false
    t.integer "status", default: 0
    t.date "submitted_at"
    t.date "completed_at"
    t.date "actual_completed_at"
    t.date "picked_up_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_tickets_on_code"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "code"
    t.bigint "site_id"
    t.bigint "step_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "ticket_id"
    t.index ["site_id"], name: "index_tracks_on_site_id"
    t.index ["step_id"], name: "index_tracks_on_step_id"
    t.index ["ticket_id"], name: "index_tracks_on_ticket_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "mid"
    t.string "first_name"
    t.string "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variables", force: :cascade do |t|
    t.string "type", null: false
    t.string "name"
    t.string "value"
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type", "name", "value"], name: "index_variables_on_type_and_name_and_value", unique: true
  end

  create_table "voice_messages", force: :cascade do |t|
    t.integer "callsid"
    t.string "address"
    t.datetime "called_at"
    t.datetime "finished_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_id"
  end

  add_foreign_key "steps", "messages"
  add_foreign_key "tracks", "tickets"
end
