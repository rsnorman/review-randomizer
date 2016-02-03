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

ActiveRecord::Schema.define(version: 20160203011930) do

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "token",      limit: 36
    t.string   "domain"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "owner_id"
  end

  add_index "companies", ["owner_id"], name: "index_companies_on_owner_id"

  create_table "pull_requests", force: :cascade do |t|
    t.integer  "repo_id"
    t.string   "title"
    t.integer  "number"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "author_id"
    t.string   "author_type", default: "User"
  end

  add_index "pull_requests", ["author_id"], name: "index_pull_requests_on_author_id"
  add_index "pull_requests", ["repo_id"], name: "index_pull_requests_on_repo_id"

  create_table "repos", force: :cascade do |t|
    t.string   "organization"
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "owner_id"
    t.integer  "company_id"
  end

  add_index "repos", ["company_id"], name: "index_repos_on_company_id"
  add_index "repos", ["owner_id"], name: "index_repos_on_owner_id"

  create_table "repos_teams", id: false, force: :cascade do |t|
    t.integer "repo_id", null: false
    t.integer "team_id", null: false
  end

  add_index "repos_teams", ["repo_id"], name: "index_repos_teams_on_repo_id"
  add_index "repos_teams", ["team_id"], name: "index_repos_teams_on_team_id"

  create_table "review_assignments", force: :cascade do |t|
    t.integer  "pull_request_id"
    t.integer  "team_membership_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "review_assignments", ["pull_request_id"], name: "index_review_assignments_on_pull_request_id"
  add_index "review_assignments", ["team_membership_id"], name: "index_review_assignments_on_team_membership_id"

  create_table "team_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.string   "handle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "team_memberships", ["team_id"], name: "index_team_memberships_on_team_id"
  add_index "team_memberships", ["user_id"], name: "index_team_memberships_on_user_id"

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "leader_id"
    t.integer  "company_id"
  end

  add_index "teams", ["company_id"], name: "index_teams_on_company_id"
  add_index "teams", ["leader_id"], name: "index_teams_on_leader_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "handle"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "email",                            default: "",     null: false
    t.string   "encrypted_password",               default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "role",                   limit: 5, default: "User"
    t.integer  "company_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id"
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
