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

ActiveRecord::Schema.define(:version => 20100121060219) do

  create_table "articles", :force => true do |t|
    t.integer  "user_id"
    t.string   "title",            :limit => 100
    t.string   "permalink",        :limit => 50
    t.text     "body"
    t.datetime "published_at"
    t.string   "category",         :limit => 30
    t.string   "author",           :limit => 30
    t.boolean  "approved",                        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "short_body"
    t.datetime "expires_on"
    t.boolean  "protected_record",                :default => false
  end

  add_index "articles", ["approved"], :name => "index_articles_on_approved"
  add_index "articles", ["permalink"], :name => "index_articles_on_permalink", :unique => true

  create_table "birthdays", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.datetime "birthdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "birthdays", ["birthdate"], :name => "index_birthdays_on_birthdate"
  add_index "birthdays", ["first_name"], :name => "index_birthdays_on_first_name"
  add_index "birthdays", ["last_name"], :name => "index_birthdays_on_last_name"

  create_table "buletins", :force => true do |t|
    t.string   "title"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "size"
    t.datetime "date_time"
    t.boolean  "ninos"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "remote_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",             :limit => 40
    t.string   "email",            :limit => 40
    t.string   "website_url",      :limit => 40
    t.boolean  "approved",                       :default => false
    t.string   "user_agent"
    t.string   "referrer"
  end

  add_index "comments", ["approved"], :name => "index_comments_on_approved"
  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "event_status",   :default => "Confirmed"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "event_priority", :default => "Normal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", :force => true do |t|
    t.string   "title"
    t.string   "url",           :default => "http://"
    t.integer  "display_order", :default => 10
    t.integer  "article_id"
    t.string   "menu_type",     :default => "Link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "new_page",      :default => false
  end

  create_table "messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.text     "body"
    t.boolean  "subscribed",     :default => false
    t.boolean  "urgent_contact", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "message_read",   :default => false
    t.string   "user_agent"
    t.string   "referrer"
    t.string   "remote_ip"
    t.string   "user_id"
  end

  create_table "rates", :force => true do |t|
    t.integer  "user_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "stars"
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id"], :name => "index_rates_on_rateable_id"
  add_index "rates", ["user_id"], :name => "index_rates_on_user_id"

  create_table "settings", :force => true do |t|
    t.string   "var",        :null => false
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "display_name"
    t.string   "full_name"
    t.datetime "birthday"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "country"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.string   "office_phone"
    t.string   "nationality"
    t.boolean  "display_address"
    t.boolean  "display_phone"
    t.boolean  "admin",                                   :default => false
    t.string   "family_name"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "family_role"
    t.string   "civil_state"
    t.datetime "married_bday"
    t.string   "sacraments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_seen_at"
    t.boolean  "approved",                                :default => false
    t.string   "website"
    t.string   "login_key"
    t.datetime "login_key_expires_at"
    t.boolean  "activated",                               :default => false
    t.string   "bio"
    t.text     "bio_html"
    t.string   "openid_url"
    t.datetime "last_login_at"
    t.integer  "posts_count",                             :default => 0
  end

  add_index "users", ["last_seen_at"], :name => "index_users_on_last_seen_at"

end
