class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.column :title,  :string,  :limit => 50
      t.column :desc,   :string
      t.timestamps 
    end
  end

  def self.down
    drop_table :categories
  end
end
