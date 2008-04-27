class CreateBirthdays < ActiveRecord::Migration
  def self.up
    create_table :birthdays do |t|
      t.column :first_name,   :string
      t.column :middle_name,  :string
      t.column :last_name,    :string
      t.column :birthdate,    :datetime
      t.timestamps 
    end
  end

  def self.down
    drop_table :birthdays
  end
end
