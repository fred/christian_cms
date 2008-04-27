class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.column :title,      :string
      t.column :author,     :string
      t.column :year,       :integer
      t.column :editorial,  :string
      t.column :desc,       :text
      t.timestamps 
    end
  end

  def self.down
    drop_table :books
  end
end
