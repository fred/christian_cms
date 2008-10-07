class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index(:articles, :permalink, :unique => true)
    add_index(:birthdays, [:first_name, :last_name, :birthdate], :unique => false)
  end

  def self.down
    remove_index :articles, :permalink
    remove_index :birthdays, :column => [:first_name, :last_name, :birthdate]
  end
end
