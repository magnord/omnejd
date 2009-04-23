# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090422211716) do

  create_table "areas", :force => true do |t|
    t.column "name", :string
    t.column "user_id", :integer
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "geom", :polygon, :null => false
  end

  add_index "areas", ["geom"], :name => "index_areas_on_geom", :spatial=> true 

  create_table "areas_users", :id => false, :force => true do |t|
    t.column "area_id", :integer
    t.column "user_id", :integer
  end

  create_table "posts", :force => true do |t|
    t.column "title", :string
    t.column "body", :text
    t.column "user_id", :integer
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "pos", :point, :null => false
  end

  create_table "sweden5", :force => true do |t|
    t.column "gid", :string, :limit => 20
    t.column "name", :string, :limit => 50
    t.column "name_ascii", :string, :limit => 50
    t.column "geom", :multi_polygon
  end

  create_table "users", :force => true do |t|
    t.column "login", :string, :null => false
    t.column "email", :string, :null => false
    t.column "crypted_password", :string, :null => false
    t.column "password_salt", :string, :null => false
    t.column "persistence_token", :string, :null => false
    t.column "single_access_token", :string, :null => false
    t.column "perishable_token", :string, :null => false
    t.column "login_count", :integer, :default => 0, :null => false
    t.column "failed_login_count", :integer, :default => 0, :null => false
    t.column "last_request_at", :timestamp
    t.column "current_login_at", :timestamp
    t.column "last_login_at", :timestamp
    t.column "current_login_ip", :string
    t.column "last_login_ip", :string
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
  end

end
