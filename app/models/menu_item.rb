class MenuItem < ActiveRecord::Base
  
  # Hardcoded Types
  MENU_TYPES = ["Link", "Menu", "Sidebar"]
  
  # Filters
  after_save :sweep_partial_cache
  
  # Validations
  validates_presence_of :title
  
  def self.menus
    find(:all, 
      :order => "display_order ASC", 
      :conditions => ["menu_type = ?", "Menu"]
    )
  end
    
  def self.links
    find(:all, 
      :order => "display_order ASC", 
      :conditions => ["menu_type = ?", "Link"]
    )
  end
  
  def self.sidebars
    find(:all, 
      :order => "display_order ASC", 
      :conditions => ["menu_type = ?", "Sidebar"]
    )
  end
  
  private
  def sweep_partial_cache
    cache_dir = RAILS_ROOT+"/tmp/cache/views/*"
    FileUtils.rm_r(Dir.glob(cache_dir)) rescue Errno::ENOENT
    logger.debug("Cache '#{cache_dir}' delete.")
  end
  
      
end
