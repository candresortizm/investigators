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

ActiveRecord::Schema.define(version: 2020_03_28_172713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.string "name", null: false
    t.string "id_announcement", null: false
    t.date "date_announcement", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "big_areas", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_big_areas_on_name"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deptos", force: :cascade do |t|
    t.bigint "region_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["region_id"], name: "index_deptos_on_region_id"
  end

  create_table "formation_levels", force: :cascade do |t|
    t.string "name", null: false
    t.string "id_level", null: false
    t.integer "order_level", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "investigators", force: :cascade do |t|
    t.datetime "birthday", null: false
    t.string "gender", null: false
    t.bigint "birthplace_id", null: false
    t.bigint "current_place_id", null: false
    t.bigint "formation_level_id", null: false
    t.bigint "knowledge_speciality_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["birthplace_id"], name: "index_investigators_on_birthplace_id"
    t.index ["current_place_id"], name: "index_investigators_on_current_place_id"
    t.index ["formation_level_id"], name: "index_investigators_on_formation_level_id"
    t.index ["knowledge_speciality_id"], name: "index_investigators_on_knowledge_speciality_id"
  end

  create_table "knowledge_areas", force: :cascade do |t|
    t.bigint "big_area_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["big_area_id"], name: "index_knowledge_areas_on_big_area_id"
  end

  create_table "knowledge_specialities", force: :cascade do |t|
    t.bigint "knowledge_area_id", null: false
    t.string "name", null: false
    t.string "id_area", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id_area"], name: "index_knowledge_specialities_on_id_area"
    t.index ["knowledge_area_id"], name: "index_knowledge_specialities_on_knowledge_area_id"
  end

  create_table "municipalities", force: :cascade do |t|
    t.bigint "depto_id", null: false
    t.string "name", null: false
    t.string "dane_code", null: false
    t.string "ubic_res", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["depto_id"], name: "index_municipalities_on_depto_id"
  end

  create_table "recognition_investigators", force: :cascade do |t|
    t.bigint "investigator_id", null: false
    t.bigint "announcement_id", null: false
    t.bigint "recognition_level_id", null: false
    t.float "investigator_age", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["announcement_id"], name: "index_recognition_investigators_on_announcement_id"
    t.index ["investigator_id"], name: "index_recognition_investigators_on_investigator_id"
    t.index ["recognition_level_id"], name: "index_recognition_investigators_on_recognition_level_id"
  end

  create_table "recognition_levels", force: :cascade do |t|
    t.string "id_clas_pr", null: false
    t.string "name_clas_pr", null: false
    t.string "orden_clas_pr", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "regions", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

  add_foreign_key "deptos", "regions"
  add_foreign_key "investigators", "formation_levels"
  add_foreign_key "investigators", "knowledge_specialities"
  add_foreign_key "investigators", "municipalities", column: "birthplace_id"
  add_foreign_key "investigators", "municipalities", column: "current_place_id"
  add_foreign_key "knowledge_areas", "big_areas"
  add_foreign_key "knowledge_specialities", "knowledge_areas"
  add_foreign_key "municipalities", "deptos"
  add_foreign_key "recognition_investigators", "announcements"
  add_foreign_key "recognition_investigators", "investigators"
  add_foreign_key "recognition_investigators", "recognition_levels"
  add_foreign_key "regions", "countries"
end
