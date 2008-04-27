class Event < ActiveRecord::Base
  
  acts_as_textiled :description
    
  validates_presence_of :title
  after_save  :sweep_partial_cache
  
  #acts_as_ferret :fields => [ 'title', 'description' ]
  
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
  
  protected
  
  def sweep_partial_cache
    #cache_dir = ActionController::Base.page_cache_directory+"/.."+"/tmp/cache"
    cache_dir = RAILS_ROOT+"/tmp/cache"
    unless cache_dir == RAILS_ROOT+"/public"
      file_name1 = cache_dir+"/*"
      side_menu = "#{cache_dir}/side_menu.cache"
      #file_name1 = cache_dir+"/"+self.permalink.to_s+".cache"
      #file_name2 = cache_dir+"/articles/"+self.id.to_s+".cache"
      FileUtils.rm_r(Dir.glob(file_name1)) rescue Errno::ENOENT
      #FileUtils.rm_r(Dir.glob(file_name2)) rescue Errno::ENOENT
      RAILS_DEFAULT_LOGGER.info("Cache '#{file_name1}' delete.")
      #RAILS_DEFAULT_LOGGER.info("Cache '#{file_name2}' delete.")
    end
  end
  
end
