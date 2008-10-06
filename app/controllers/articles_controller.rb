class ArticlesController < ApplicationController

  # GET /articles
  # GET /articles.xml
  def index

    order = "published_at DESC"
    per_page = 6
    current_page = (params[:page] ||= 1).to_i

    @articles = Article.paginate :page => current_page, 
      :per_page => per_page, 
      :order => order, 
      :conditions => ["articles.approved = ?", true]
    respond_to do |format|
      format.html # index.html.erb
      format.rss
      format.atom
      format.xml  { render :xml => @articles }
    end
  end
  
  
  def search
    redirect_to :action => "index"
  end


  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find_permalink(params[:permalink]) || Article.find(params[:permalink])
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
