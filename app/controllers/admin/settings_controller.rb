# -*- encoding : utf-8 -*-
class Admin::SettingsController < Admin::BaseController

  def index
		@settings = Setting.find(:all, :order => 'var')
		@setting = Setting.new
  end

  def create
		Setting.create(params[:setting])
		redirect_to :action=>'index'
  end

  def update
		setting = Setting.find(params[:setting][:id])
		setting.update_attributes(params[:setting])
		redirect_to :action => 'index'
  end

  def delete
		Setting.find(params[:id]).destroy
		redirect_to :action => 'index'
  end
  
  # TODO 
  def manteinance
    case params[:task]
      # clean the temp caches.
      when "cache" then clean_cache
      # clean the temp caches.
      when "session" then clean_session
      else
        redirect_to settings_url
    end
    
    redirect_to settings_url
  end
  
  
  protected
  
  def clean_session
    dir = RAILS_ROOT+"/tmp/session"
    all_files = dir+"/*"
    FileUtils.rm_r(Dir.glob(all_files)) rescue Errno::ENOENT
    RAILS_DEFAULT_LOGGER.info("All Files in '#{all_files}' delete.")
    flash[:notice] = "Site Reloaded, session files cleaned"
  rescue
    flash[:notice] = "Error, could not clean the session files"
    redirect_to settings_url
  end
  
  def clean_cache
    dir = RAILS_ROOT+"/tmp/cache"
    all_files = dir+"/*"
    FileUtils.rm_r(Dir.glob(all_files)) rescue Errno::ENOENT
    RAILS_DEFAULT_LOGGER.info("All Files in '#{all_files}' delete.")
    flash[:notice] = "Site Reloaded, all cache files cleaned"
  rescue
    flash[:notice] = "Error, could not clean the cache files"
    redirect_to settings_url
  end
  
  
end
