class Buletin < ActiveRecord::Base
  
  has_attachment :storage => :file_system, 
                 :max_size => 10.megabytes,
		             :processor => "MiniMagick"
  
  validates_as_attachment
  
  def self.find_paginated(per_page, current_page, order_by)
    self.find(:all,
      :order => order_by, 
      :page => { :size => per_page, :current => current_page, :first => 1 }
    )
  end

  def self.get_latest
    Buletin.find(:all, :conditions => ["month(created_at) = ?", Time.now.month])
  end
    
end
