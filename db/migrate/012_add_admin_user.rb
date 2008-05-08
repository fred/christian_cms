class AddAdminUser < ActiveRecord::Migration
  def self.up
    User.create :login => "admin",
      :password => "admin",
      :password_confirmation => "admin",
      :email => "root@localhost",
      :first_name => "Administrator"
    ActiveRecord::Base.connection.execute("update users set admin = '1' where login = 'admin'")
  end

  def self.down
  end
end
