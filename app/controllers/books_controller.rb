class BooksController < ApplicationController
  
  #layout 'pristine'
  layout 'toader'
  
  #before_filter :login_from_cookie
  
  before_filter :admin, :except => [ :index, :show, :search ]

  # GET /books
  # GET /books.xml
  def index
    if params[:sort]
      order = case params[:sort]
        when "title"    then "title ASC"
        when "author"   then "author DESC"
        when "year"     then "year DESC"
      end
    else
      order = "title ASC"
    end
    per_page = 10
    current_page = (params[:page] ||= 1).to_i
    
    if @books
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @books }
      end
    else
      @books = Book.paginate :page => current_page, :per_page => per_page, :order => order
    end
    @query ||= ""
  end
  
  def search
    if params[:search] && params[:search][:q] != ""
      @query = params[:search][:q]
      per_page = 10
      current_page = (params[:page] ||= 1).to_i
      @books = Book.find_with_ferret_paginated(@query, {:page => current_page, :per_page => per_page})
      #, {:page => current_page, :per_page => per_page})
    else
      per_page = 10
      current_page = (params[:page] ||= 1).to_i
      @books = Book.paginate :page => current_page, :per_page => per_page
      flash[:notice] = 'No fue encrontrado ningún libro.'
    end
    render :action => "index"
  end


  # GET /books/1
  # GET /books/1.xml
  def show
    if params[:id]
      @book = Book.find(params[:id])
    else
      @book = Book.find_permalink(params[:permalink])
    end
    @meta_title = @meta_title + " - " + @book.title 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        flash[:notice] = "Libro fue creado con Suceso."
        format.html { redirect_to book_path(@book) }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    @book = Book.find(params[:id])
    
    respond_to do |format|
      if @book.update_attributes(params[:book])
        flash[:notice] = "Libro fue actualizado con Suceso."
        format.html { redirect_to book_path(@book) }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    respond_to do |format|
      format.html { redirect_to("/") }
      format.xml  { head :ok }
    end
  end
  
  
end
