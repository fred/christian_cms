class RemoveUnusedModels < ActiveRecord::Migration
  def self.up
    drop_table :money_rates
    drop_table :news
    drop_table :weathers
  end

  def self.down
    create_table "news", :force => true do |t|
      t.integer  "user_id"
      t.string   "title",        :limit => 50
      t.string   "permalink",    :limit => 50
      t.text     "body"
      t.datetime "published_at"
      t.integer  "category_id"
      t.string   "author",       :limit => 50
      t.boolean  "approved",                   :default => true
      t.boolean  "show_front",                 :default => true
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    create_table "money_rates", :force => true do |t|
      t.string   "name"
      t.string   "convert_from"
      t.string   "convert_to"
      t.string   "convert_result"
      t.integer  "expire_time"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    create_table "money_rates", :force => true do |t|
      t.string   "name"
      t.string   "convert_from"
      t.string   "convert_to"
      t.string   "convert_result"
      t.integer  "expire_time"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    create_table "weathers", :force => true do |t|
      t.string   "zipcode"
      t.string   "city"
      t.string   "region"
      t.string   "country"
      t.string   "temperature_high"
      t.string   "temperature_low"
      t.string   "temperature_units"
      t.string   "link"
      t.date     "recorded_at"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
