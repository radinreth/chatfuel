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

ActiveRecord::Schema.define(version: 2020_02_06_023217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "lead_id", null: false
    t.index ["lead_id"], name: "index_activities_on_lead_id"
  end

  create_table "answers", force: :cascade do |t|
    t.string "variable_name"
    t.string "value"
    t.bigint "voice_message_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["voice_message_id"], name: "index_answers_on_voice_message_id"
  end

  create_table "identities", force: :cascade do |t|
    t.string "provider"
    t.string "token"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "leads", force: :cascade do |t|
    t.string "mid"
    t.string "first_name"
    t.string "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "content_type"
    t.integer "content_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_type", "content_id"], name: "index_messages_on_content_type_and_content_id"
  end

  create_table "steps", force: :cascade do |t|
    t.string "act", null: false
    t.string "value", null: false
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

  create_table "voice_answers", force: :cascade do |t|
    t.string "project_variable_name"
    t.string "value"
    t.bigint "voice_message_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["voice_message_id"], name: "index_voice_answers_on_voice_message_id"
  end

  create_table "voice_messages", force: :cascade do |t|
    t.integer "CallSid"
    t.string "address"
    t.datetime "called_at"
    t.datetime "finished_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "voices", force: :cascade do |t|
    t.string "call_sid"
    t.string "status"
    t.string "from"
    t.integer "call_duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "activities", "leads"
  add_foreign_key "answers", "voice_messages"
  add_foreign_key "identities", "users"
  add_foreign_key "steps", "messages"
end
