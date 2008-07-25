class BuletinsController < ApplicationController
  
  before_filter :admin, :except => [ :index, :list, :show ]
  
  # GET /articles
  # GET /articles.xml
  def index
    @buletin = Buletin.new
    if params[:sort]
      order = case params[:sort]
        when "title" then "title ASC, created_at ASC"
        when "file_name"  then "filename ASC"
        when "date"  then "created_at DESC"
      end
    else
      order = "created_at DESC"
    end
    per_page = 40
    current_page = (params[:page] ||= 1).to_i
    @buletins = Buletin.paginate :page => current_page, :per_page => per_page, :order => order
  end

  
  def new
    @buletin = Buletin.new
  end
  
  def create
    @buletin = Buletin.new(params[:buletin])
    if @buletin.save
      flash[:notice] = 'Boletin fue creado con suceso.'
      redirect_to buletins_path
    else
      render :action => :index
    end
  end
  
  def edit
    @buletin = Buletin.find(params[:id])
  end

  def update
    @buletin = Buletin.find(params[:id])
    if @buletin.update_attributes(params[:buletin])
      flash[:notice] = 'Buletin was successfully updated.'
      redirect_to buletins_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    if @buletin = Buletin.find(params[:id]).destroy
      redirect_to buletins_path
    end
  rescue
    redirect_to :action => "index"
  end
  
end
