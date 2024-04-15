# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_15_141339) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider"
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emotion_categories", force: :cascade do |t|
    t.bigint "emotion_id", null: false
    t.bigint "user_category_id", null: false
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emotion_id"], name: "index_emotion_categories_on_emotion_id"
    t.index ["user_category_id"], name: "index_emotion_categories_on_user_category_id"
  end

  create_table "emotion_messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "emotion_id", null: false
    t.bigint "user_template_id", null: false
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emotion_id"], name: "index_emotion_messages_on_emotion_id"
    t.index ["user_id"], name: "index_emotion_messages_on_user_id"
    t.index ["user_template_id"], name: "index_emotion_messages_on_user_template_id"
  end

  create_table "emotion_partners", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "partner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_emotion_partners_on_user_id", unique: true
  end

  create_table "emotions", force: :cascade do |t|
    t.string "feeling", null: false
    t.integer "feeling_score"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_emotions_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.integer "status", default: 0
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_invitations_on_receiver_id"
    t.index ["sender_id"], name: "index_invitations_on_sender_id"
  end

  create_table "message_templates", force: :cascade do |t|
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_categories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_user_categories_on_category_id"
    t.index ["user_id"], name: "index_user_categories_on_user_id"
  end

  create_table "user_templates", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "message_template_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_template_id"], name: "index_user_templates_on_message_template_id"
    t.index ["user_id"], name: "index_user_templates_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.string "crypted_password"
    t.string "salt"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "line_user_id"
    t.string "unique_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["unique_id"], name: "index_users_on_unique_id", unique: true
  end

  add_foreign_key "emotion_categories", "emotions"
  add_foreign_key "emotion_categories", "user_categories"
  add_foreign_key "emotion_messages", "emotions"
  add_foreign_key "emotion_messages", "user_templates"
  add_foreign_key "emotion_messages", "users"
  add_foreign_key "emotions", "users"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_categories", "users"
  add_foreign_key "user_templates", "message_templates"
  add_foreign_key "user_templates", "users"
end
