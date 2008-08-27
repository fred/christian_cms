class MenuItems < ActiveRecord::Migration
  def self.up
    create_table :menu_items do |t|
      t.string    :title
      t.string    :url, :default => "http://"
      t.integer   :display_order, :default => 10
      t.integer   :article_id
      t.string    :menu_type, :default => "Link"
      t.timestamps
    end
  end

  def self.down
    drop_table :menu_items
  end
end
