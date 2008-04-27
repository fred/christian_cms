class SettingsController < ApplicationController
  
  before_filter :admin

  layout 'toader'
  
  # GET /settings
  # GET /settings.xml
  def index
    order = "var ASC"
    per_page = 50
    current_page = (params[:page] ||= 1).to_i
    @settings = Setting.paginate :page => current_page, :per_page => per_page, :order => order

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @settings.to_xml }
    end
  end

  # GET /settings/1
  # GET /settings/1.xml
  def show
    @setting = Setting.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @setting.to_xml }
    end
  end

  # GET /settings/new
  def new
    @setting = Setting.new
  end

  # GET /settings/1/edit
  def edit
    @setting = Setting.find(params[:id])
  end

  # POST /settings
  # POST /settings.xml
  def create
    @setting = Setting.new(params[:setting])

    respond_to do |format|
      if @setting.save
        flash[:notice] = 'Setting was successfully created.'
        format.html { redirect_to settings_path }
        format.xml  { head :created, :location => setting_url(@setting) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @setting.errors.to_xml }
      end
    end
  end

  # PUT /settings/1
  # PUT /settings/1.xml
  def update
    @setting = Setting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        flash[:notice] = 'Setting was successfully updated.'
        format.html { redirect_to settings_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setting.errors.to_xml }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.xml
  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy

    respond_to do |format|
      format.html { redirect_to settings_url }
      format.xml  { head :ok }
    end
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
