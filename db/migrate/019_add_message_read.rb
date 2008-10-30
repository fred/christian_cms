class AddMessageRead < ActiveRecord::Migration
  def self.up
    add_column :messages, :message_read, :boolean, :default => false
  end

  def self.down
    remove_column :messages, :message_read
  end
end
