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

ActiveRecord::Schema.define(version: 20170723181523) do

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "cat"
    t.string "flavor"
    t.boolean "celery"
    t.boolean "cereal"
    t.boolean "crustacean"
    t.boolean "egg"
    t.boolean "fish"
    t.boolean "lupin"
    t.boolean "milk"
    t.boolean "mollusc"
    t.boolean "mustard"
    t.boolean "nut"
    t.boolean "peanut"
    t.boolean "sesame"
    t.boolean "soya"
    t.boolean "sulphites"
  end

  create_table "meals", force: :cascade do |t|
    t.integer "menu_id"
    t.string "name"
    t.string "description"
    t.boolean "traces_of_nuts"
    t.boolean "traces_of_gluten"
    t.boolean "traces_of_lactose"
    t.boolean "vegitarian"
    t.boolean "vegan"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "cat"
  end

  create_table "recipies", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "ingredient_id"
    t.integer "quantity"
    t.string "measure"
    t.boolean "modify"
  end

end
