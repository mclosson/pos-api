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

ActiveRecord::Schema.define(:version => 20120930135458) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "api_keys", :force => true do |t|
    t.string   "access_token"
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "expires_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "description"
    t.text     "notes"
    t.boolean  "inactive"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "employee_clock_ins", :force => true do |t|
    t.datetime "clockin_datetime"
    t.datetime "clockout_datetime"
    t.integer  "hours_worked"
    t.integer  "location_id"
    t.integer  "user_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "genders", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
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

  create_table "payment_types", :force => true do |t|
    t.integer  "location_id"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "payments", :force => true do |t|
    t.integer  "ticket_id"
    t.float    "amount"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "payment_type_id"
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

  create_table "skus", :force => true do |t|
    t.string   "sku"
    t.integer  "location_id"
    t.text     "description"
    t.datetime "inbound_date"
    t.integer  "supplier_id"
    t.integer  "article_id"
    t.integer  "gender_id"
    t.string   "sex"
    t.string   "model"
    t.integer  "inbound_qty"
    t.integer  "outbound_qty"
    t.integer  "lost_qty"
    t.integer  "transferred_qty"
    t.integer  "transferred_in_qty"
    t.string   "min_stock_integer"
    t.float    "sales_price"
    t.float    "cost_price"
    t.float    "cost_price_igic"
    t.boolean  "inactive"
    t.integer  "unit_size_id"
    t.string   "color"
    t.boolean  "synchronized"
    t.integer  "season_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.string   "telephone"
    t.text     "notes"
    t.boolean  "inactive"
    t.integer  "margin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "unit_sizes", :force => true do |t|
    t.string   "size"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "employee_id"
    t.boolean  "enabled"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "password_digest"
    t.string   "shortname"
    t.string   "username"
    t.integer  "account_id"
    t.integer  "default_location"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
