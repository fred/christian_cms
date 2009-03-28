class Event < ActiveRecord::Base
  
  EVENT_STATUS = ["Confirmed", "Not Confirmed"]
  PRIORITIES = ["Normal", "Important", "Very Important"]
  
  # Validations
  validates_presence_of :title
  
  def self.get_this_month
    month = Time.now.month
    Event.find(:all, 
      :limit => 10, 
      :conditions => ["month(start_date) = ?", month],
      :order => "day(start_date) ASC"
    )
  end
  
  # Sphinx Search method
  def self.full_text_search(q, limit, order_by)
     return nil if q.nil? or q==""
     results = self.find_by_contents(q,
      :order => order_by, 
      :limit => limit
     )
     return results
  end
    
end
