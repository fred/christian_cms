class AddSpamField < ActiveRecord::Migration
  def self.up
    add_column :comments, :marked_spam, :boolean, :default => false
    add_column :messages, :marked_spam, :boolean, :default => false
  end

  def self.down
    remove_column :comments, :marked_spam
    remove_column :messages, :marked_spam
  end
end
