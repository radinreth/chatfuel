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


ActiveRecord::Schema.define(version: 2020_04_17_030807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer "status", default: 0
    t.string "media_url"
    t.bigint "step_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["step_id"], name: "index_feedbacks_on_step_id"
  end

  create_table "identities", force: :cascade do |t|
    t.string "provider"
    t.string "token"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content_type"
    t.integer "content_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.string "platform_name", default: ""
    t.index ["content_type", "content_id"], name: "index_messages_on_content_type_and_content_id"
  end

  create_table "role_variables", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "variable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_role_variables_on_role_id"
    t.index ["variable_id"], name: "index_role_variables_on_variable_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "settings", force: :cascade do |t|
    t.text "incompleted_text"
    t.text "completed_text"
  end
  
  create_table "quota", force: :cascade do |t|
    t.string "platform_name", default: "messenger"
    t.integer "threshold", default: 0
    t.float "secure_zone", default: 0.75
    t.integer "total_sent", default: 0
    t.string "on_reach_threshold", default: "delay"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "feedback_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "variable_value_id", null: false
    t.index ["feedback_id"], name: "index_ratings_on_feedback_id"
    t.index ["variable_value_id"], name: "index_ratings_on_variable_value_id"
  end

  create_table "role_variables", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "variable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_role_variables_on_role_id"
    t.index ["variable_id"], name: "index_role_variables_on_variable_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "settings", force: :cascade do |t|
    t.text "incompleted_text"
    t.text "completed_text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sites", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", default: ""
    t.integer "tracks_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.index ["name"], name: "index_sites_on_name"
  end

  create_table "step_values", force: :cascade do |t|
    t.bigint "step_id", null: false
    t.bigint "variable_value_id", null: false
    t.bigint "site_id"
    t.index ["site_id"], name: "index_step_values_on_site_id"
    t.index ["step_id"], name: "index_step_values_on_step_id"
    t.index ["variable_value_id"], name: "index_step_values_on_variable_value_id"
  end

  create_table "steps", force: :cascade do |t|
    t.bigint "message_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id"], name: "index_steps_on_message_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "content", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "text_messages", force: :cascade do |t|
    t.string "messenger_user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "profile_pic_url"
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
    t.integer "role", default: 0
    t.integer "status", default: 0
    t.bigint "site_id"
    t.bigint "role_id", default: 1, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["site_id"], name: "index_users_on_site_id"
  end

  create_table "variable_values", force: :cascade do |t|
    t.string "raw_value", null: false
    t.string "mapping_value", default: ""
    t.integer "status", default: 0
    t.bigint "variable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["variable_id"], name: "index_variable_values_on_variable_id"
  end

  create_table "variables", force: :cascade do |t|
    t.string "type", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "report_enabled", default: false
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "identities", "users"
  add_foreign_key "role_variables", "roles"
  add_foreign_key "role_variables", "variables"
  add_foreign_key "step_values", "sites"
  add_foreign_key "step_values", "steps"
  add_foreign_key "step_values", "variable_values"
  add_foreign_key "steps", "messages"
  add_foreign_key "users", "roles"
  add_foreign_key "variable_values", "variables"
end
