class IncreaseArticleTitleLength < ActiveRecord::Migration
  def self.up
    change_column :articles, :title, :string, :limit => 100
    change_column :articles, :permalink, :string, :limit => 50
  end

  def self.down
    change_column :articles, :title, :string, :limit => 50
    change_column :articles, :permalink, :string, :limit => 30
  end
end
