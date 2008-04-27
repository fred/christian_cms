class Setting < ActiveRecord::Base
  
  validates_uniqueness_of :var
  
  after_save :sweep_partial_cache
    
  protected
  
  def sweep_partial_cache
    #cache_dir = ActionController::Base.page_cache_directory+"/.."+"/tmp/cache"
    cache_dir = RAILS_ROOT+"/tmp/cache"
    unless cache_dir == RAILS_ROOT+"/public"
      all_files = cache_dir+"/*"
      FileUtils.rm_r(Dir.glob(all_files)) rescue Errno::ENOENT
      RAILS_DEFAULT_LOGGER.info("All Files in the Cache '#{all_files}' delete.")
    end
  end
  
end
