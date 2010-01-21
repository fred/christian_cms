class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
    @comment.remote_ip = request.remote_ip
    @comment.referrer  = request.referrer
    @comment.user_agent = request.env["HTTP_USER_AGENT"]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.remote_ip = request.remote_ip
    @comment.referrer  = request.referrer
    @comment.user_agent = request.env["HTTP_USER_AGENT"]
    @article = Article.find(@comment.commentable_id)
    if logged_in?
      @comment.user_id = current_user.id
    end
    
    if @comment.spam?
      @comment.marked_spam = true 
      logger.warn "Message marked as spam. Akismet Response: #{@comment.akismet_response}"
    end
    
    respond_to do |format|
      if @comment.valid? && !@comment.marked_spam && @comment.save
        flash[:notice] = 'Gracias. Su mensaje estar a ser autorizado.'
        format.html { redirect_to article_path(@article) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        flash[:error] = 'Mensaje marcado como SPAM, si eso fue engano, por favor contact el administrador.'
        format.html { redirect_to article_path(@article) }
        format.js { render :xml => @comment.errors, :status => "405"}
        format.xml  { render :xml => @comment.errors, :status => "405" }
      end
    end
  end
  
end
