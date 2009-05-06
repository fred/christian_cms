class Admin::BuletinsController < Admin::BaseController
  
  # GET /articles
  # GET /articles.xml
  def index
    if params[:sort]
      order = case params[:sort]
        when "title" then "title ASC, created_at ASC"
        when "file_name"  then "filename ASC"
        when "date"  then "created_at DESC"
      end
    else
      order = "created_at DESC"
    end
    per_page = 20
    current_page = (params[:page] ||= 1).to_i
    @buletins = Buletin.paginate :page => current_page, :per_page => per_page, :order => order
    
    @buletin = Buletin.new
  end

  
  def new
    @buletin = Buletin.new
  end
  
  def create
    @buletin = Buletin.new(params[:buletin])
    if @buletin.save
      flash[:notice] = 'Boletin fue creado con suceso.'
      redirect_to admin_buletins_path
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
      flash[:notice] = 'Buletin fue Actualizado con successo.'
      redirect_to admin_buletins_path
    else
      render :action => 'edit'
    end
  end
  
  
  # DELETE /admin/buletins/1
  # DELETE /admin/buletins/1.xml
  def destroy
    if Buletin.find(params[:id]).destroy
      flash[:notice] = "Boletin apagado con successo."
      redirect_to admin_buletins_path
    end
  rescue
    flash[:notice] = "Boletin no pudo ser apagado."
    redirect_to :action => "index"
  end
  
end
