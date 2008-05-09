require 'digest/sha1'
class UsersController < ApplicationController
  
  before_filter :login_required, :except => [ :show, :index, :new, :create, :search ]

  def index
    if params[:sort]
      order = case params[:sort]
        when "first_name"   then "first_name ASC, last_name ASC"
        when "last_name"    then "last_name ASC, first_name ASC"
      end
    else
      order = "last_name ASC, first_name ASC"
    end
    per_page = 30
    current_page = (params[:page] ||= 1).to_i
    if authorized_admin?
      conditions = ""
    else
      conditions = ["users.approved = ?", true]
    end
    @users = User.paginate :page => current_page, 
      :per_page => per_page, 
      :order => order,
      :conditions => conditions
  end
  
  def search
    per_page = 20
    current_page = (params[:page] ||= 1).to_i
    if params[:search] && params[:search][:q] != ""
      @query = params[:search][:q]
      @users = User.find_with_ferret_paginated(@query, {:page => current_page, :per_page => per_page})
    else
      @users = User.paginate :page => current_page, :per_page => per_page
      flash[:notice] = 'No fue encrontrado ningún Usuario.'
    end
    render :action => "index"
  end

  # render new.rhtml
  def new
    @user = User.new
  end

  def create
    cookies.delete :auth_token
    @user = User.new(params[:user])
    if @user.valid_with_captcha?
      @user.save!
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Gracias por registrarse!"
    else
      flash[:notice] = "Verifique la imagen abajo corectament!"
      render :action => 'new'
    end
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end
  

  def show
    if authorized_admin?
      conditions = nil
    else
      conditions = ["users.approved = ?", true]
    end
    @user = User.find(params[:id],
      :conditions => conditions
    )      
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  rescue
    flash[:notice] = "Usuario no Disponible al Publico."
    redirect_to users_path
  end


  # GET /users/1/edit
  def edit
    if authorized_admin? && params[:id]
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id)
    end
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  def update
    if authorized_admin? && params[:id]
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id)
    end
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Usuario fue Actualizado.'
      redirect_to user_path(@user)
    else
      render :action => "edit"
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to "/users" }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def initial_password_email
    @users = User.find(:all)
    @users.each do |user|
      if user.email
        Notifier.deliver_initial_password_email(user)
        sleep 2
      end
    end
    redirect_to "/"
  end
  
  def mass_email(msg_time,msg_subject,msg_body)
    @users = User.find(:all)
    @users.each do |user|
      if user.email
        Notifier.deliver_mass_email(user,msg_time,msg_subject,msg_body)
        sleep 5
      end
    end
    redirect_to "/"
  end
  
end
