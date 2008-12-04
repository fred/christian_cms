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
    
    if params[:id] && authorized_admin?
      @article = Article.find(params[:id])
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
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
  
end
