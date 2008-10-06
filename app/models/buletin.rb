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
   
   
  after_save :sweep_partial_cache
  
  private
  def sweep_partial_cache
    cache_dir = RAILS_ROOT+"/tmp/cache/views/*"
    FileUtils.rm_r(Dir.glob(cache_dir)) rescue Errno::ENOENT
    logger.debug("Cache '#{cache_dir}' delete.")
  end
  
end
