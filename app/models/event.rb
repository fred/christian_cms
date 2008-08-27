class Event < ActiveRecord::Base
  
  acts_as_textiled :description
    
  validates_presence_of :title
  after_save  :sweep_partial_cache
  
  def self.get_this_month
    month = Time.now.month
    Event.find(:all, 
      :limit => 10, 
      :conditions => ["month(start_date) = ?", month],
      :order => "day(start_date) ASC"
    )
  end
  
  def self.full_text_search(q, limit, order_by)
     return nil if q.nil? or q==""
     results = self.find_by_contents(q,
      :order => order_by, 
      :limit => limit
     )
     return results
  end
  
  def self.find_paginated(per_page, current_page, order_by)
    self.find(:all,
      :order => order_by, 
      :page => { :size => per_page, :current => current_page, :first => 1 }
    )
  end
    
end
