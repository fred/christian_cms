class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string    :title
      t.string    :event_status, :default => "Confirmed"
      t.text      :description
      t.datetime  :start_date
      t.datetime  :end_date
      t.string    :event_priority, :default => "Normal"
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
