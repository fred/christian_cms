class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.column "user_id",         :integer
      t.column "title",           :string,  :limit => 50
      t.column "permalink",       :string,  :limit => 30
      t.column "body",            :text
      t.column "published_at",    :datetime
      t.column "category",        :string,  :limit => 30
      t.column "author",          :string,  :limit => 30
      t.column "approved",        :boolean, :default => false
      t.timestamps 
    end
  end

  def self.down
    drop_table :articles
  end
end

