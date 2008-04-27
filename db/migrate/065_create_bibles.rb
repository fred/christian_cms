class CreateBibles < ActiveRecord::Migration
  def self.up
    create_table :bibles do |t|
      t.column :title, :string
      t.column :desc,  :text
      t.timestamps
    end
  end

  def self.down
    drop_table :bibles
  end
end
