class CreateBuletins < ActiveRecord::Migration
  def self.up
    create_table :buletins do |t|
      t.column :title,        :string
      t.column :content_type, :string
      t.column :filename,     :string    
      t.column :size,         :integer
      t.column :date_time,    :datetime
      t.column :ninos,        :boolean
      t.timestamps 
    end
  end

  def self.down
    drop_table :buletins
  end
end
