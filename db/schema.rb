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

ActiveRecord::Schema.define(version: 2020_03_27_093711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "event_details", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_event_details_on_deleted_at"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "result_id"
    t.bigint "player_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "event_detail_id"
    t.string "minute", default: "", null: false
    t.index ["deleted_at"], name: "index_events_on_deleted_at"
    t.index ["event_detail_id"], name: "index_events_on_event_detail_id"
    t.index ["player_id"], name: "index_events_on_player_id"
    t.index ["result_id"], name: "index_events_on_result_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "turn"
    t.string "place"
    t.datetime "time"
    t.integer "winner_id"
    t.bigint "round_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "time_end"
    t.index ["deleted_at"], name: "index_matches_on_deleted_at"
    t.index ["round_id"], name: "index_matches_on_round_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id"
    t.string "position"
    t.integer "number"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_players_on_deleted_at"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "status", default: false
    t.bigint "user_id"
    t.string "category", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "count_views", default: 0
    t.index ["deleted_at"], name: "index_posts_on_deleted_at"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "ranks", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "round_id"
    t.integer "goals_for", default: 0, null: false
    t.integer "goals_against", default: 0, null: false
    t.integer "win", default: 0, null: false
    t.integer "lose", default: 0, null: false
    t.integer "draw", default: 0, null: false
    t.integer "score", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_ranks_on_deleted_at"
    t.index ["round_id"], name: "index_ranks_on_round_id"
    t.index ["team_id"], name: "index_ranks_on_team_id"
  end

  create_table "results", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "match_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "goals", default: 0
    t.index ["deleted_at"], name: "index_results_on_deleted_at"
    t.index ["match_id"], name: "index_results_on_match_id"
    t.index ["team_id"], name: "index_results_on_team_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_roles_on_deleted_at"
  end

  create_table "round_details", force: :cascade do |t|
    t.string "name", null: false
    t.string "round_type", null: false
    t.integer "num_of_teams"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_round_details_on_deleted_at"
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "tournament_id"
    t.string "name", null: false
    t.boolean "is_return", null: false
    t.bigint "round_detail_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_rounds_on_deleted_at"
    t.index ["round_detail_id"], name: "index_rounds_on_round_detail_id"
    t.index ["tournament_id"], name: "index_rounds_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "tournament_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_teams_on_deleted_at"
    t.index ["tournament_id"], name: "index_teams_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "formula"
    t.datetime "time_start"
    t.datetime "time_end"
    t.boolean "is_finish"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_tournaments_on_deleted_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "reset_digest"
    t.datetime "reset_send_at"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "role_id"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
