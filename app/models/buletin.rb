class Buletin < ActiveRecord::Base
  
  #acts_as_cached
  #after_save :expire_cache
  #after_save :expire_my_cache
  
  has_attachment :storage => :file_system, 
                 :max_size => 990.kilobytes,
		 :processor => "MiniMagick"
  
  validates_as_attachment
  
  def self.find_paginated(per_page, current_page, order_by)
    self.find(:all,
      :order => order_by, 
      #:conditions => ["cokey = ? AND company_id = ?", User.current_user.cokey, User.current_user.company_id],
      :page => { :size => per_page, :current => current_page, :first => 1 }
    )
  end

  def self.get_latest
    #Buletin.cached(:all).find_all {|t| t.created_at.month == Time.now.month }
    Buletin.find(:all, :conditions => ["month(created_at) = ?", Time.now.month])
  end
  
  #def self.all
  #  self.find(:all)
  #end
  
  
  private
  
  #def expire_my_cache
    #Buletin.clear_cache(:all)
  #end
  
end
