class AddMenuItemNewPage < ActiveRecord::Migration
  def self.up
    add_column :menu_items, :new_page, :boolean, :default => false
  end

  def self.down
    remove_column :menu_items, :new_page
  end
end
