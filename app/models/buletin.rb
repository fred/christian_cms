class Buletin < ActiveRecord::Base
  
  # Plugins
  validates_as_attachment
  has_attachment :storage => :file_system, 
                 :max_size => 10.megabytes,
		             :processor => "MiniMagick"
  
  # Filters
  after_save :sweep_partial_cache
  
  ### Methods ###

  def self.get_latest
    time = Time.now
    Buletin.find(:all, :conditions => ["month(created_at) = ? AND year(created_at) = ?", time.month, time.year])
  end
  
  private
  def sweep_partial_cache
    cache_dir = RAILS_ROOT+"/tmp/cache/views/*"
    FileUtils.rm_r(Dir.glob(cache_dir)) rescue Errno::ENOENT
    logger.debug("Cache '#{cache_dir}' delete.")
  end
  
end
