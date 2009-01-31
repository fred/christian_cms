class AddCommentsMigration < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :title, :limit => 50, :default => "" 
      t.text :comment, :default => "" 
      t.references :commentable, :polymorphic => true
      t.references :user
      t.string :remote_ip
      t.timestamps
      
      t.string :name, :limit => 40
      t.string :email, :limit => 40
      t.string :website_url, :limit => 40
      t.boolean :approved, :default => false
      
    end

    add_index :comments, :commentable_type
    add_index :comments, :commentable_id
    add_index :comments, :user_id
    add_index :comments, :approved
  end

  def self.down
    drop_table :comments
  end
end