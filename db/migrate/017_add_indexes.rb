class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index(:articles, :permalink, :unique => true)
    add_index(:articles, :approved)
    add_index(:birthdays, :first_name)
    add_index(:birthdays, :last_name)
    add_index(:birthdays, :birthdate)
  end

  def self.down
    remove_index :articles, :permalink
    remove_index :articles, :approved
    remove_index :birthdays, :first_name
    remove_index :birthdays, :last_name
    remove_index :birthdays, :birthdate
  end
end
