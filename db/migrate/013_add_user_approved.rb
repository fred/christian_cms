class AddUserApproved < ActiveRecord::Migration
  def self.up
    add_column :users, :approved, :boolean, :default => false
    User.update_all(:approved => false)
  end

  def self.down
    remove_column :users, :approved
  end
end
