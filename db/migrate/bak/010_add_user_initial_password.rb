class AddUserInitialPassword < ActiveRecord::Migration
  
  def self.up
    add_column :users, :initial_password, :string
  end
  
  def self.down
    remove_column :users, :initial_password
  end
end
