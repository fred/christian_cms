class CreateUserRoles < ActiveRecord::Migration
  def self.up
    create_table :user_roles do |t|
      t.column :user_id, :integer
      t.column :role_id, :integer
      t.timestamps 
    end
  end

  def self.down
    drop_table :user_roles
  end
end
