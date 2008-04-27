class AddFieldsUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_login_at, :datetime
    add_column :users, :posts_count, :integer, :default => 0
  end

  def self.down
    drop_table :users
  end
end
