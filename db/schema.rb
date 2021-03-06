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

ActiveRecord::Schema.define(version: 20_160_714_005_033) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'categories', force: :cascade do |t|
    t.string   'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'order_items', force: :cascade do |t|
    t.integer  'product_id'
    t.integer  'order_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_index 'order_items', ['order_id'], name: 'index_order_items_on_order_id', using: :btree
  add_index 'order_items', ['product_id'], name: 'index_order_items_on_product_id', using: :btree

  create_table 'orders', force: :cascade do |t|
    t.integer  'user_id'
    t.decimal  'total'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_index 'orders', ['user_id'], name: 'index_orders_on_user_id', using: :btree

  create_table 'organizations', force: :cascade do |t|
    t.string   'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_index 'organizations', ['name'], name: 'index_organizations_on_name', using: :btree

  create_table 'product_weekdays', force: :cascade do |t|
    t.integer  'product_id'
    t.integer  'weekday_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_index 'product_weekdays', ['product_id'], name: 'index_product_weekdays_on_product_id', using: :btree
  add_index 'product_weekdays', ['weekday_id'], name: 'index_product_weekdays_on_weekday_id', using: :btree

  create_table 'products', force: :cascade do |t|
    t.string   'name'
    t.decimal  'price', precision: 12, scale: 3
    t.integer  'category_id'
    t.datetime 'created_at',                           null: false
    t.datetime 'updated_at',                           null: false
  end

  create_table 'profiles', force: :cascade do |t|
    t.integer  'user_id'
    t.string   'last_name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_index 'profiles', ['user_id'], name: 'index_profiles_on_user_id', using: :btree

  create_table 'roles', force: :cascade do |t|
    t.string   'name'
    t.integer  'resource_id'
    t.string   'resource_type'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'roles', %w(name resource_type resource_id), name: 'index_roles_on_name_and_resource_type_and_resource_id', using: :btree
  add_index 'roles', ['name'], name: 'index_roles_on_name', using: :btree

  create_table 'social_profiles', force: :cascade do |t|
    t.integer  'user_id'
    t.string   'uid'
    t.string   'service_name'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
  end

  add_index 'social_profiles', %w(user_id service_name), name: 'index_social_profiles_on_user_id_and_service_name', unique: true, using: :btree
  add_index 'social_profiles', ['user_id'], name: 'index_social_profiles_on_user_id', using: :btree

  create_table 'users', force: :cascade do |t|
    t.string   'email',                  default: '', null: false
    t.string   'encrypted_password',     default: '', null: false
    t.string   'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer  'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet     'current_sign_in_ip'
    t.inet     'last_sign_in_ip'
    t.datetime 'created_at',                          null: false
    t.datetime 'updated_at',                          null: false
    t.string   'first_name'
    t.string   'authentication_token'
    t.integer  'organization_id'
  end

  add_index 'users', ['authentication_token'], name: 'index_users_on_authentication_token', using: :btree
  add_index 'users', ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true, using: :btree

  create_table 'users_roles', id: false, force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'role_id'
  end

  add_index 'users_roles', %w(user_id role_id), name: 'index_users_roles_on_user_id_and_role_id', using: :btree

  create_table 'weekdays', force: :cascade do |t|
    t.string   'name'
    t.date     'date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
