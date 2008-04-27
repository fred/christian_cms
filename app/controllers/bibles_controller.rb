class BiblesController < ApplicationController
  
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
  
  def upload
    @attachment = Attachment.new(params[:attachment])
    #"name","contact","phone-number","fax_number","desc","address1","address2","city","state","postal","country","email"
    if @attachment.save
      @attachment.rewind
      @attachment.each do |t|
        s = StringScanner.new(t)
        name = s.scan(/\w+/)
        s.pos = s.pos+1
        chapter = s.scan(/\w+/)
        s.pos = s.pos+1
        versicle = s.scan(/\w+/)
        body = s.rest

        if apostol = Apostol.find(:first,:conditions => ["short_name = ?",name])
          apostol_id = apostol.id
        else
          apostol = Apostol.create :short_name => name, :bible_id => 1
          apostol_id = apostol.id
        end

        if bible_text = BibleText.find(:first, :conditions => ["apostol_id = ? AND chapter = ? AND versicle = ?", apostol_id, chapter, versicle])
          bible_text.destroy
          logger.info "Repeated Text was found. The text was deleted"
        end
        bible_text = BibleText.create :apostol_id => apostol_id, :chapter => chapter, :versicle => versicle, :body => body
        logger.info "Text Created"
        logger.info bible_text.inspect
        plogger.infouts "==============================="
      end
    else
      render :action => :upload
    end
  end
  
end
