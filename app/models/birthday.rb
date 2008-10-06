class Birthday < ActiveRecord::Base
  
  validates_presence_of :first_name
  
  def self.full_text_search(q, limit, order_by)
     return nil if q.nil? or q==""
     results = self.find_by_contents(q,
      :order => order_by, 
      :limit => limit
     )
     results
  end
  
  def self.find_paginated(per_page, current_page, order_by)
    self.find(:all,
      :order => order_by, 
      :page => { :size => per_page, :current => current_page, :first => 1 }
    )
  end
  
  def self.get_this_month
      #Birthday.cached(:all).find_all {|t| t.birthdate.month == Time.now.month }
      Birthday.find(:all, 
        :conditions => ["month(birthdate) = ?", Time.now.month],
        :order => "day(birthdate) ASC"
      )
  end
  
  def self.get_by_month(month)
      #Birthday.cached(:all).find_all {|t| t.birthdate.month.to_s == month }
      Birthday.find(:all, 
        :conditions => ["month(birthdate) = ?", month],
        :order => "day(birthdate) ASC"
      )
  end
  
  def self.all
    self.find(:all, :order => "month(birthdate) ASC, day(birthdate) ASC")
  end
  
  
  
  after_save :sweep_partial_cache
  
  private
  def sweep_partial_cache
    cache_dir = RAILS_ROOT+"/tmp/cache/views/*"
    FileUtils.rm_r(Dir.glob(cache_dir)) rescue Errno::ENOENT
    logger.debug("Cache '#{cache_dir}' delete.")
  end
  
  
    
end
