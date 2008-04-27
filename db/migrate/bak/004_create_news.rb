class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.column "user_id",         :integer
      t.column "title",           :string,  :limit => 50
      t.column "permalink",       :string,  :limit => 50
      t.column "body",            :text
      t.column "published_at",    :datetime
      t.column "category_id",     :integer
      t.column "author",          :string,  :limit => 50
      t.column "approved",        :boolean, :default => true
      t.column "show_front",      :boolean, :default => true
      t.timestamps 
    end
  end

  def self.down
    drop_table :news
  end
end
