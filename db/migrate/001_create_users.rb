class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      
      t.column :display_name,     :string
      t.column :full_name,        :string
      t.column :birthday,         :datetime
      t.column :address1,         :string
      t.column :address2,         :string
      t.column :city,             :string
      t.column :country,          :string
      t.column :home_phone,       :string
      t.column :mobile_phone,     :string
      t.column :office_phone,     :string
      t.column :nationality,      :string
      t.column :display_address,  :boolean
      t.column :display_phone,    :boolean
      t.column :admin,            :boolean, :default => false
      
      t.column :family_name,    :string
      t.column :first_name,     :string
      t.column :middle_name,    :string
      t.column :last_name,      :string
      t.column :family_role,    :string
      t.column :civil_state,    :string
      t.column :married_bday,   :datetime
      t.column :sacraments,     :string
      
      t.timestamps 
      end

      #User.create :name => "Aministrator",
      #  :id             => 1,
      #  :admin          => true,
      #  :login          => "admin",
      #  :password       => "admin",   
      #  :password_confirmation => "admin",
      #  :sales_code     => "ADMIN",
      #  :created_at     => Time.now,
      #  :updated_at     => Time.now,
      #  :email          => "admin@admin.local"
    end

  def self.down
    drop_table "users"
  end
end
