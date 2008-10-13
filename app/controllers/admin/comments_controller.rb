class Admin::CommentsController < Admin::BaseController
  
  # GET /admin/comments
  # GET /admin/comments.xml
  def index
    @comments = Comment.find(:all, :order => "created_at DESC")
  end

  # GET /admin/comments/1
  # GET /admin/comments/1.xml
  def show
    @comment = Comment.find(params[:id])
  end

  # GET /admin/comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # PUT /admin/comments/1
  # PUT /admin/comments/1.xml
  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = 'Comment was successfully updated.'
      redirect_to(:action => "index") 
    else
      render :action => "edit"
    end
  end

  # DELETE /admin/comments/1
  # DELETE /admin/comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to(:action => "index")
  end
  
  def approve
    @comment = Comment.find(params[:id])
    @comment.update_attributes(:approved => true)
    redirect_back_or_default(:action => 'index')
  end
  
  def unapprove
    @comment = Comment.find(params[:id])
    @comment.update_attributes(:approved => false)
    redirect_back_or_default(:action => 'index')
  end
end
