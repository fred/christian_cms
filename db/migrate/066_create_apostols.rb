class CreateApostols < ActiveRecord::Migration
  def self.up
    create_table :apostols do |t|
      t.column :short_name, :string, :limit => 6
      t.column :full_name,  :string, :limit => 40
      t.column :desc,       :text
      t.column :bible_id,   :integer
      t.timestamps
    end
    add_index(:apostols, :short_name)
    add_index(:apostols, :bible_id)
  end

  def self.down
    drop_table :apostols
  end
end
