class AddKismetFieldsToCommentsAndMessages < ActiveRecord::Migration
  def self.up
    add_column :comments, :user_agent, :string
    add_column :comments, :referrer, :string
    
    add_column :messages, :user_agent, :string
    add_column :messages, :referrer, :string
    add_column :messages, :remote_ip, :string
    add_column :messages, :user_id, :string
  end

  def self.down
    remove_column :comments, :user_agent
    remove_column :comments, :referrer
    remove_column :messages, :user_agent
    remove_column :messages, :user_id
    remove_column :messages, :remote_ip
    remove_column :messages, :referrer
  end
end
