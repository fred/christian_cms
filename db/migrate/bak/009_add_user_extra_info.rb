class AddUserExtraInfo < ActiveRecord::Migration
  def self.up
    add_column :users, :family_name,    :string
    add_column :users, :first_name,     :string
    add_column :users, :middle_name,    :string
    add_column :users, :last_name,      :string
    add_column :users, :family_role,    :string
    add_column :users, :civil_state,    :string
    add_column :users, :married_bday,   :datetime
    add_column :users, :sacraments,     :string
  end

  def self.down
  end
end
