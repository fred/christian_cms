class AddProtectedArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :protected_record, :boolean, :default => false
    change_column_default :articles, :approved, true
  end

  def self.down
    change_column_default :articles, :approved, false
    remove_column :articles, :protected_record
  end
end
