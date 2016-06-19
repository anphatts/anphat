# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160426145943) do

  create_table "assignments", id: false, force: :cascade do |t|
    t.integer "user_id",   limit: 4, null: false
    t.integer "lesson_id", limit: 4, null: false
  end

  add_index "assignments", ["lesson_id"], name: "index_assignments_on_lesson_id", using: :btree
  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id", using: :btree

  create_table "class_has_subjects", id: false, force: :cascade do |t|
    t.integer "class_id",   limit: 4, null: false
    t.integer "subject_id", limit: 4, null: false
  end

  add_index "class_has_subjects", ["class_id"], name: "fk_classes_has_subjects_classes1_idx", using: :btree
  add_index "class_has_subjects", ["subject_id"], name: "fk_classes_has_subjects_subjects1_idx", using: :btree

  create_table "classes", force: :cascade do |t|
    t.string "name", limit: 45
  end

  add_index "classes", ["name"], name: "name_UNIQUE", unique: true, using: :btree

  create_table "comments", id: false, force: :cascade do |t|
    t.integer  "id",         limit: 4,  null: false
    t.string   "content",    limit: 45, null: false
    t.datetime "created_at",            null: false
    t.integer  "user_id",    limit: 4,  null: false
    t.integer  "lesson_id",  limit: 4,  null: false
  end

  add_index "comments", ["lesson_id"], name: "fk_comments_lessons1_idx", using: :btree
  add_index "comments", ["user_id"], name: "fk_comments_users1_idx", using: :btree

  create_table "commontator_comments", force: :cascade do |t|
    t.string   "creator_type",      limit: 255
    t.integer  "creator_id",        limit: 4
    t.string   "editor_type",       limit: 255
    t.integer  "editor_id",         limit: 4
    t.integer  "thread_id",         limit: 4,                 null: false
    t.text     "body",              limit: 65535,             null: false
    t.datetime "deleted_at"
    t.integer  "cached_votes_up",   limit: 4,     default: 0
    t.integer  "cached_votes_down", limit: 4,     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_comments", ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down", using: :btree
  add_index "commontator_comments", ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up", using: :btree
  add_index "commontator_comments", ["creator_id", "creator_type", "thread_id"], name: "index_commontator_comments_on_c_id_and_c_type_and_t_id", using: :btree
  add_index "commontator_comments", ["thread_id", "created_at"], name: "index_commontator_comments_on_thread_id_and_created_at", using: :btree

  create_table "commontator_subscriptions", force: :cascade do |t|
    t.string   "subscriber_type", limit: 255, null: false
    t.integer  "subscriber_id",   limit: 4,   null: false
    t.integer  "thread_id",       limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_subscriptions", ["subscriber_id", "subscriber_type", "thread_id"], name: "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", unique: true, using: :btree
  add_index "commontator_subscriptions", ["thread_id"], name: "index_commontator_subscriptions_on_thread_id", using: :btree

  create_table "commontator_threads", force: :cascade do |t|
    t.string   "commontable_type", limit: 255
    t.integer  "commontable_id",   limit: 4
    t.datetime "closed_at"
    t.string   "closer_type",      limit: 255
    t.integer  "closer_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_threads", ["commontable_id", "commontable_type"], name: "index_commontator_threads_on_c_id_and_c_type", unique: true, using: :btree

  create_table "downloads", id: false, force: :cascade do |t|
    t.integer "user_id",   limit: 4, null: false
    t.integer "lesson_id", limit: 4, null: false
  end

  add_index "downloads", ["lesson_id"], name: "index_downloads_on_lesson_id", using: :btree
  add_index "downloads", ["user_id"], name: "index_downloads_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "grade_has_classes", id: false, force: :cascade do |t|
    t.integer "grade_id", limit: 4, null: false
    t.integer "class_id", limit: 4, null: false
  end

  add_index "grade_has_classes", ["class_id", "grade_id"], name: "index_grade_has_classes_on_class_id_and_grade_id", using: :btree
  add_index "grade_has_classes", ["grade_id", "class_id"], name: "index_grade_has_classes_on_grade_id_and_class_id", using: :btree

  create_table "grades", force: :cascade do |t|
    t.string "name", limit: 200
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type", limit: 255
    t.integer  "impressionable_id",   limit: 4
    t.integer  "user_id",             limit: 4
    t.string   "controller_name",     limit: 255
    t.string   "action_name",         limit: 255
    t.string   "view_name",           limit: 255
    t.string   "request_hash",        limit: 255
    t.string   "ip_address",          limit: 255
    t.string   "session_hash",        limit: 255
    t.text     "message",             limit: 65535
    t.text     "referrer",            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: {"impressionable_type"=>nil, "message"=>255, "impressionable_id"=>nil}, using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "name",            limit: 50,                  null: false
    t.string   "url",             limit: 200,                 null: false
    t.datetime "created_at",                                  null: false
    t.boolean  "approved",        limit: 1,   default: false, null: false
    t.integer  "class_id",        limit: 4,                   null: false
    t.integer  "user_id",         limit: 4,                   null: false
    t.integer  "subject_id",      limit: 4
    t.string   "represent_image", limit: 200
    t.integer  "type_id",         limit: 4,                   null: false
    t.boolean  "isAssignment",    limit: 1,   default: false
    t.integer  "approver_id",     limit: 4
  end

  add_index "lessons", ["approver_id"], name: "index_lessons_on_approver_id", using: :btree
  add_index "lessons", ["class_id"], name: "fk_lessons_classes1_idx", using: :btree
  add_index "lessons", ["subject_id"], name: "fk_lessons_subjects1_idx", using: :btree
  add_index "lessons", ["type_id"], name: "fk_lessons_types1_idx", using: :btree
  add_index "lessons", ["user_id"], name: "fk_lessons_users1_idx", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "role", limit: 45
  end

  create_table "school_has_classes", id: false, force: :cascade do |t|
    t.integer "school_id", limit: 4, null: false
    t.integer "class_id",  limit: 4, null: false
  end

  add_index "school_has_classes", ["class_id"], name: "fk_schools_has_classes_classes1_idx", using: :btree
  add_index "school_has_classes", ["school_id"], name: "fk_schools_has_classes_schools1_idx", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string  "name",     limit: 45
    t.integer "grade_id", limit: 4,   null: false
    t.string  "slug",     limit: 255
    t.integer "pdt_id",   limit: 4
  end

  add_index "schools", ["grade_id"], name: "fk_schools_grades1_idx", using: :btree
  add_index "schools", ["name"], name: "name_UNIQUE", unique: true, using: :btree
  add_index "schools", ["pdt_id"], name: "index_schools_on_pdt_id", using: :btree
  add_index "schools", ["slug"], name: "index_schools_on_slug", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string "subject_name", limit: 45
    t.string "slug",         limit: 45
  end

  add_index "subjects", ["subject_name"], name: "subject_name_UNIQUE", unique: true, using: :btree

  create_table "types", force: :cascade do |t|
    t.string "name", limit: 45
  end

  create_table "user_has_role", id: false, force: :cascade do |t|
    t.integer "role_id", limit: 4, null: false
    t.integer "user_id", limit: 4, null: false
  end

  add_index "user_has_role", ["role_id"], name: "fk_roles_has_users_roles1_idx", using: :btree
  add_index "user_has_role", ["user_id"], name: "fk_roles_has_users_users1_idx", using: :btree

  create_table "users", force: :cascade do |t|
    t.string  "username",        limit: 20,  null: false
    t.string  "password_digest", limit: 255
    t.string  "remember_digest", limit: 255
    t.string  "name",            limit: 50,  null: false
    t.string  "email",           limit: 45,  null: false
    t.string  "workplace",       limit: 200
    t.integer "school_id",       limit: 4
  end

  add_index "users", ["email"], name: "email_UNIQUE", unique: true, using: :btree
  add_index "users", ["school_id"], name: "fk_users_schools1_idx", using: :btree
  add_index "users", ["username"], name: "username_UNIQUE", unique: true, using: :btree

  add_foreign_key "assignments", "lessons"
  add_foreign_key "assignments", "users"
  add_foreign_key "class_has_subjects", "classes", name: "fk_classes_has_subjects_classes1"
  add_foreign_key "class_has_subjects", "subjects", name: "fk_classes_has_subjects_subjects1"
  add_foreign_key "comments", "lessons", name: "fk_comments_lessons1"
  add_foreign_key "comments", "users", name: "fk_comments_users1"
  add_foreign_key "downloads", "lessons"
  add_foreign_key "downloads", "users"
  add_foreign_key "grade_has_classes", "classes"
  add_foreign_key "grade_has_classes", "grades"
  add_foreign_key "lessons", "classes", name: "fk_lessons_classes1"
  add_foreign_key "lessons", "subjects", name: "fk_lessons_subjects1"
  add_foreign_key "lessons", "types", name: "fk_lessons_types1"
  add_foreign_key "lessons", "users", column: "approver_id"
  add_foreign_key "lessons", "users", name: "approver"
  add_foreign_key "lessons", "users", name: "approver_id"
  add_foreign_key "lessons", "users", name: "fk_lessons_users1"
  add_foreign_key "schools", "grades", name: "fk_schools_grades1"
  add_foreign_key "schools", "schools", column: "pdt_id"
end
