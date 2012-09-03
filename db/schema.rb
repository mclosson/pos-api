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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120903153502) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "line_items", :force => true do |t|
    t.integer  "sales_ticket_id"
    t.integer  "quantity"
    t.float    "sales_price"
    t.string   "sku"
    t.boolean  "void"
    t.integer  "discount"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.text     "description"
    t.boolean  "direct_distribution"
    t.string   "fax"
    t.boolean  "active"
    t.boolean  "overwrite_cost_price"
    t.boolean  "overwrite_sales_price"
    t.boolean  "overwrite_season"
    t.string   "phone"
    t.string   "province"
    t.boolean  "round_sales_price"
    t.string   "short_description"
    t.string   "zipcode"
    t.integer  "account_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "sales_tickets", :force => true do |t|
    t.integer  "location_id"
    t.boolean  "multi_payment"
    t.integer  "payment_type"
    t.boolean  "refunds_returns_allowed"
    t.integer  "sales_person_id"
    t.boolean  "synchronized"
    t.float    "tax_amount"
    t.float    "tax_rate"
    t.boolean  "ticket_cleared"
    t.datetime "ticket_cleared_datetime"
    t.datetime "ticket_datetime"
    t.datetime "ticket_expired"
    t.datetime "ticket_expired_refund"
    t.integer  "vip_client_id"
    t.boolean  "void"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "employee_id"
    t.boolean  "enabled"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "password"
    t.string   "shortname"
    t.string   "username"
    t.integer  "account_id"
    t.integer  "default_location"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
