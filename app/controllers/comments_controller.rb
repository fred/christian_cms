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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.remote_ip = request.remote_ip
    @article = Article.find(@comment.commentable_id)
    if logged_in?
      @comment.user_id = current_user.id
    end

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Thank you. Your comment is awaiting approval.'
        format.html { redirect_to article_path(@article) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { redirect_to article_path(@article) }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
