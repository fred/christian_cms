class ArticlesController < ApplicationController

  before_filter :admin, :except => [ :index, :list, :show, :search, :old_action ]

  # GET /articles
  # GET /articles.xml
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

    @articles = Article.paginate :page => current_page, 
      :per_page => per_page, 
      :order => order, 
      :conditions => ["articles.approved = ?", true]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end
  
  
  def search
    if params[:search] && !params[:search][:q].to_s.empty?
      @query = params[:search][:q]
      per_page = 20
      current_page = (params[:page] ||= 1).to_i
      @articles = Article.find_with_ferret_paginated(@query, {:page => current_page, :per_page => per_page})
    else
      @articles = []
      flash[:notice] = 'No fue encrontrado ningún Articulo.'
    end
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

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to "/" }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:notice] = "Articule fue actualizado con Suceso."
        redirect_to "/"
        #format.html { redirect_to :action => "index" }
        #format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to("/") }
      format.xml  { head :ok }
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

end
