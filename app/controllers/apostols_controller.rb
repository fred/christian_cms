class ApostolsController < ApplicationController
  
  layout 'toader'
    
  before_filter :admin, :except => [ :index, :show, :search ]
  
  # GET /apostols
  # GET /apostols.xml
  def index    
    if params[:sort]
      order = case params[:sort]
        when "short_name" then "short_name ASC"
        when "date"  then "created_at DESC"
      end
    else
      order = "created_at DESC"
    end
    per_page = 6
    current_page = (params[:page] ||= 1).to_i
    @apostols = Apostol.paginate :page => current_page, 
      :per_page => per_page, 
      :order => order
      
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apostols }
    end
  end

  # GET /apostols/1
  # GET /apostols/1.xml
  def show
    @apostols = Apostol.find(:all)
    @apostol = Apostol.find(params[:id])
    
    @chapter = (params[:chapter] ||= 1).to_i  
    @next = (@chapter.to_i)+1
    @previous = (@chapter.to_i)-1 if @chapter > 1
    
    @chapters = BibleText.find(:all, 
      :select => "id,chapter",
      :group => "chapter",
      :conditions => ["apostol_id = ?", @apostol.id]
    )
        
    @bible_texts = BibleText.find(:all, 
      :conditions => ["apostol_id = ? AND chapter = ?", @apostol.id, @chapter]
    )
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apostol }
    end
  end
  
  # GET /apostols/new
  # GET /apostols/new.xml
  def new
    @apostol = Apostol.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @apostol }
    end
  end

  # GET /apostols/1/edit
  def edit
    @apostol = Apostol.find(params[:id])
  end

  # POST /apostols
  # POST /apostols.xml
  def create
    @apostol = Apostol.new(params[:apostol])

    respond_to do |format|
      if @apostol.save
        flash[:notice] = 'Apostol was successfully created.'
        format.html { redirect_to(@apostol) }
        format.xml  { render :xml => @apostol, :status => :created, :location => @apostol }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @apostol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /apostols/1
  # PUT /apostols/1.xml
  def update
    @apostol = Apostol.find(params[:id])

    respond_to do |format|
      if @apostol.update_attributes(params[:apostol])
        flash[:notice] = 'Apostol was successfully updated.'
        format.html { redirect_to(@apostol) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @apostol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /apostols/1
  # DELETE /apostols/1.xml
  def destroy
    @apostol = Apostol.find(params[:id])
    @apostol.destroy

    respond_to do |format|
      format.html { redirect_to(apostols_url) }
      format.xml  { head :ok }
    end
  end
  
end

