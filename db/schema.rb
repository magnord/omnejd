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

ActiveRecord::Schema.define(:version => 20090907090302) do

  create_table "areas", :force => true do |t|
    t.column "name", :string, :null => false
    t.column "user_id", :integer
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "geom", :polygon, :null => false
  end

  add_index "areas", ["geom"], :name => "index_areas_on_geom", :spatial=> true 

  create_table "bas99", :force => true do |t|
    t.column "basnamn", :string
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "geom", :polygon, :null => false
  end

  add_index "bas99", ["geom"], :name => "index_bas99_on_geom", :spatial=> true 

  create_table "delayed_jobs", :force => true do |t|
    t.column "priority", :integer, :default => 0
    t.column "attempts", :integer, :default => 0
    t.column "handler", :text
    t.column "last_error", :string
    t.column "run_at", :timestamp
    t.column "locked_at", :timestamp
    t.column "failed_at", :timestamp
    t.column "locked_by", :string
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
  end

  create_table "posts", :force => true do |t|
    t.column "title", :string
    t.column "body", :text
    t.column "user_id", :integer
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "cached_tag_list", :string
    t.column "pos", :point, :null => false
  end

  create_table "samswgs84", :force => true do |t|
    t.column "samscode", :string
    t.column "samsnamn", :string
    t.column "kommun", :string
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "geom", :multi_polygon, :null => false
  end

  add_index "samswgs84", ["geom"], :name => "index_samswgs84_on_geom", :spatial=> true 

  create_table "sweden5", :force => true do |t|
    t.column "gid", :string, :null => false
    t.column "name", :string
    t.column "name_ascii", :string
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "geom", :multi_polygon, :null => false
  end

  add_index "sweden5", ["geom"], :name => "index_sweden5_on_geom", :spatial=> true 

  create_table "taggings", :force => true do |t|
    t.column "tag_id", :integer
    t.column "taggable_id", :integer
    t.column "taggable_type", :string
    t.column "created_at", :timestamp
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.column "name", :string
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
    t.column "avatar_file_name", :string
    t.column "avatar_content_type", :string
    t.column "avatar_file_size", :integer
    t.column "avatar_updated_at", :timestamp
  end

  create_table "watched_areas", :force => true do |t|
    t.column "user_id", :integer
    t.column "area_id", :integer
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
  end

end
