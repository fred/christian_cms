class CreateBibleTexts < ActiveRecord::Migration
  def self.up
    create_table :bible_texts do |t|
      t.column :apostol_id, :integer
      t.column :chapter,  :integer, :limit => 4
      t.column :versicle, :integer, :limit => 4
      t.column :body,     :text
      t.timestamps
    end
    add_index(:bible_texts, :apostol_id)
    add_index(:bible_texts, :chapter)
    add_index(:bible_texts, :versicle)
  end

  def self.down
    drop_table :bible_texts
  end
end
