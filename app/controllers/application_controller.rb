# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  include AuthenticatedSystem
  
  #include CacheableFlash
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery :secret => 'o81e062ae93Pd7e0c63rg4L8hx61jb5'

  # get the layout from settings table, 
  # rescue in order to work before the migrations
  layout "themes/#{Settings.theme}" rescue "themes/default"
  
  before_filter :login_from_cookie
  
  before_filter :get_links
  
  def get_links
    @sidebar_items = MenuItem.sidebar_items
    @link_items = MenuItem.link_items
  end
  
  def initialize
		@start_time = Time.now
	end
	
  
  def get_rate
    @rate = MoneyRate.get_rate("USD","THB")
    Time.zone = "Bangkok"
    @time = Time.current
  end
  
  def set_current_user
    if logged_in?
      User.current_user = current_user
    end
  end
  
  def admin
    unless authorized_admin?
      redirect_to "/"
    end
  end
  
  # Coverts to english latin1/spanish/portugues characters 
  #  that should not be part of the permalink.
  def strip_diacritics(s)
    s.tr("ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÑÒÓÔÕÖØÙÚÛÜÝàáâãäåçèéêëìíîïñòóôõöøùúûüýÿ",
         "AAAAAACEEEEIIIINOOOOOOUUUUYaaaaaaceeeeiiiinoooooouuuuyy")
  end
  
  protected

    def sweep_partial_cache
      @@last_sweep = Time.now
      cache_dir = RAILS_ROOT+"/tmp/cache"
      unless cache_dir == RAILS_ROOT+"/public"
        file_name1 = cache_dir+"/*"
        FileUtils.rm_r(Dir.glob(file_name1)) rescue Errno::ENOENT
        RAILS_DEFAULT_LOGGER.info("Cache '#{file_name1}' delete.")
      end
    end
      
end
