# -*- encoding : utf-8 -*-
class ArticlesController < ApplicationController

  # GET /articles
  # GET /articles.xml
  def index
    per_page = 6
    current_page = (params[:page] ||= 1).to_i
    @articles = Article.paginate :page => current_page, 
      :per_page => per_page, 
      :order => "published_at DESC", 
      :conditions => ["articles.approved = ?", true]
    respond_to do |format|
      format.html # index.html.erb
      format.rss
      format.atom
      format.xml  { render :xml => @articles }
    end
  end
  
  
  def search
    if params[:query]
      @articles = Article.search(params[:query], 
        :page => params[:page], 
        :per_page => 5,
        :order => "published_at DESC",
        :conditions => {:approved => 1}
      )
      render :action => "index"
    else
      redirect_to :action => "index"
    end
  end


  # GET /articles/1
  # GET /articles/1.xml
  def show
    
    if params[:permalink]
      @article = Article.find_permalink(params[:permalink])
    end
    
    if params[:id] 
      @article = Article.find(params[:id])
    end
    
    @comments = @article.approved_comments
    @comment = Comment.new
    @comment.commentable_id = @article.id
    @comment.commentable_type = @article.class
    if logged_in?
      @comment.name = current_user.first_name
      @comment.email = current_user.email
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end
  
  def tags
    
    if params[:tag]
      per_page = 10
      current_page = (params[:page] ||= 1).to_i

      @articles = Article.tagged_with(params[:tag], :on => "tags").paginate :page => current_page, 
        :per_page => per_page, 
        :order => "published_at DESC", 
        :conditions => ["articles.approved = ?", true]
      render :action => "index"
    else
      redirect_to :action => "index"
    end
  end
  
  def rate
    @article = Article.find(params[:id])
    @article.rate(params[:stars], current_user, params[:dimension])
    id = "ajaxful-rating-#{!params[:dimension].blank? ? "#{params[:dimension]}-" : ''}article-#{@article.id}" 
    render :update do |page|
      page.replace_html id, ratings_for(@article, :wrap => false, :dimension => params[:dimension])
      page.visual_effect :highlight, id
    end
  end
  
  
  def moved_permanently
    # this is good if you have old articles deleted 
    # or changed the tittle of an article, then
    # search engines will see 301 and delete it on their index.
    flash[:notice] = "Sorry, Article not found or moved permanently"
    @title = "Sorry, Article not found or moved permanently"
    headers["Status"] = "301 Moved Permanently"
    redirect_to "/"
  end  


  def feed
    @articles = Article.find(:all, 
      :order => 'created_at DESC',
      :conditions => ["articles.approved = ?", true],
      :limit => 10
    )
    render :layout => false
  end
  
  # Build an rss feed
  def rss
    @headers["Content-Type"] = "application/xml"
    @articles = Article.find(:all, 
      :order => 'created_at DESC',
      :conditions => ["articles.approved = ?", true],
      :limit => 10
    )
    render :layout => false
  end
  
  def processes_list
    render :text => "<pre>" + `ps -axcr -o "pid, pcpu, pmem, time, comm"` + "</pre>"
  end
  
end
