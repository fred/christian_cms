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
  #before_filter :get_rate
  
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
  
  def strip_diacritics(s)
    # latin1 subset only
    s.tr("ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÑÒÓÔÕÖØÙÚÛÜÝàáâãäåçèéêëìíîïñòóôõöøùúûüýÿ",
         "AAAAAACEEEEIIIINOOOOOOUUUUYaaaaaaceeeeiiiinoooooouuuuyy")
  end
  
  protected
    def meta_defaults
      @meta_title = "Bienvenido a Comunidad Catolica Latina en Bangkok, Thailand"
      @meta_description = "Donde los Catolicos Latinos se reúnen en Bangkok"
    end

    def rescue_action(exception)
      exception.is_a?(ActiveRecord::RecordInvalid) ? render_invalid_record(exception.record) : super
    end

    def render_invalid_record(record)
      render :action => (record.new_record? ? 'new' : 'edit')
    end

    def monthly_sweep
      sweep_partial_cache if @@last_sweep.nil?
      @time_diff = Time.now - @@last_sweep
      @time_diff = ((@time_diff/60)/24).to_i
      if (Time.now.day > 1) & (@time_diff > 28)
        sweep_partial_cache
      end
    end

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
