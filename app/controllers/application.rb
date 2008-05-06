# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  include AuthenticatedSystem
  #include Spawn
  helper :all # include all helpers, all the time

  layout "themes/#{Settings[:theme]}"
  
  before_filter :login_from_cookie
  before_filter :get_rate
  
  def get_rate
    @rate = MoneyRate.get_rate("USD","THB")
    @time = Time.now+11.hours
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
    #cache_dir = ActionController::Base.page_cache_directory+"/.."+"/tmp/cache"
    cache_dir = RAILS_ROOT+"/tmp/cache"
    unless cache_dir == RAILS_ROOT+"/public"
      file_name1 = cache_dir+"/*"
      #file_name1 = cache_dir+"/"+self.permalink.to_s+".cache"
      #file_name2 = cache_dir+"/articles/"+self.id.to_s+".cache"
      FileUtils.rm_r(Dir.glob(file_name1)) rescue Errno::ENOENT
      #FileUtils.rm_r(Dir.glob(file_name2)) rescue Errno::ENOENT
      RAILS_DEFAULT_LOGGER.info("Cache '#{file_name1}' delete.")
      #RAILS_DEFAULT_LOGGER.info("Cache '#{file_name2}' delete.")
    end
  end
      
end
