class Admin::CommentsController < Admin::BaseController
  
  # GET /admin/comments
  # GET /admin/comments.xml
  def index
    @comments = Comment.find(:all, 
      :order => "approved ASC, created_at DESC"
    )

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @comments }
    end
  end

  # GET /admin/comments/1
  # GET /admin/comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @comment }
    end
  end

  # GET /admin/comments/new
  # GET /admin/comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @comment }
    end
  end

  # GET /admin/comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /admin/comments
  # POST /admin/comments.xml
  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(@comment) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/comments/1
  # PUT /admin/comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/comments/1
  # DELETE /admin/comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(admin_comments_url) }
      format.xml  { head :ok }
    end
  end
  
  def mark_spam
    @comment = Comment.find(params[:id])
    @comment.spam!
    @comment.destroy
    flash[:notice] = 'Comment was submitted as spam and Deleted.'
    redirect_back_or_default(:action => 'index')
  end
  
  def approve
    @comment = Comment.find(params[:id])
    @comment.update_attributes(:approved => true)
    flash[:notice] = 'Comment was approved.'
    redirect_back_or_default(:action => 'index')
  end
  
  def unapprove
    @comment = Comment.find(params[:id])
    @comment.update_attributes(:approved => false)
    flash[:notice] = 'Comment was unapproved.'
    redirect_back_or_default(:action => 'index')
  end
end
