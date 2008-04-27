class BibleTextsController < ApplicationController
  
  layout 'toader'
    
  before_filter :admin, :except => [ :index, :show, :search ]
  
  # GET /bibles
  # GET /bibles.xml
  def index    
    if params[:sort]
      order = case params[:sort]
        when "title" then "title ASC"
        when "date"  then "created_at DESC"
      end
    else
      order = "created_at DESC"
    end
    per_page = 6
    current_page = (params[:page] ||= 1).to_i
    @bibles = Bible.paginate :page => current_page, 
      :per_page => per_page, 
      :order => order
      
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bibles }
    end
  end

  # GET /bibles/1
  # GET /bibles/1.xml
  def show
    @bible = Bible.find(params[:id], :include => :apostols)
    @apostols = @bible.apostols
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bible }
    end
  end

  # GET /bibles/new
  # GET /bibles/new.xml
  def new
    @bible = Bible.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bible }
    end
  end

  # GET /bibles/1/edit
  def edit
    @bible = Bible.find(params[:id])
  end

  # POST /bibles
  # POST /bibles.xml
  def create
    @bible = Bible.new(params[:bible])

    respond_to do |format|
      if @bible.save
        flash[:notice] = 'Bible was successfully created.'
        format.html { redirect_to(@bible) }
        format.xml  { render :xml => @bible, :status => :created, :location => @bible }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bible.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bibles/1
  # PUT /bibles/1.xml
  def update
    @bible = Bible.find(params[:id])

    respond_to do |format|
      if @bible.update_attributes(params[:bible])
        flash[:notice] = 'Bible was successfully updated.'
        format.html { redirect_to(@bible) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bible.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bibles/1
  # DELETE /bibles/1.xml
  def destroy
    @bible = Bible.find(params[:id])
    @bible.destroy

    respond_to do |format|
      format.html { redirect_to(bibles_url) }
      format.xml  { head :ok }
    end
  end
  
end
