# +----------------+--------------+------+-----+-----------+----------------+
# | Field          | Type         | Null | Key | Default   | Extra          |
# +----------------+--------------+------+-----+-----------+----------------+
# | id             | int(11)      | NO   | PRI | NULL      | auto_increment | 
# | title          | varchar(255) | YES  |     | NULL      |                | 
# | event_status   | varchar(255) | YES  |     | Confirmed |                | 
# | description    | text         | YES  |     | NULL      |                | 
# | start_date     | datetime     | YES  |     | NULL      |                | 
# | end_date       | datetime     | YES  |     | NULL      |                | 
# | event_priority | varchar(255) | YES  |     | Normal    |                | 
# | created_at     | datetime     | YES  |     | NULL      |                | 
# | updated_at     | datetime     | YES  |     | NULL      |                | 
# +----------------+--------------+------+-----+-----------+----------------+
class Event < ActiveRecord::Base
  
  EVENT_STATUS = ["Confirmed", "Not Confirmed"]
  PRIORITIES = ["Normal", "Important", "Very Important"]
  
  acts_as_textiled :description
    
  validates_presence_of :title
  
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
