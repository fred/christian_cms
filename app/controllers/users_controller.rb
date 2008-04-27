require 'digest/sha1'
class UsersController < ApplicationController
  
  #layout 'pristine'
  layout 'toader'
  
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
    
    #if params[:user_icon] && params[:user_icon][:uploaded_data]
      #@user_icon = UserIcon.new(params[:user_icon])
    #end
    
    if @user.update_attributes(params[:user])
      #if params[:user_icon] && params[:user_icon][:uploaded_data]
        #@user_icon.user_id = @user.id
        #@user_icon.save
      #end
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
        sleep 2
      end
    end
    redirect_to "/"
  end
  
  def import(filename)
    # FORMAT : 
    #Familia, 1. Apellido, 2. Apellido, Nombre, Nacionalidad, Parentesco, Estado civil, Cumpleanos, Aniv. Bodas,
    #Domicilio, Tel. Habitacion, Tel. Mobil, E-mail, Sacramentos Recibidos (hijos)
    
    # EXAMPLE :
    #De Souza Araujo,Araujo,De Souza,Federico,Brasil,Hijo,soltero,11-Jun,,
    #"Sukhumvit Soi 12, Apt 3A, Bangkok",02-229-4598,083-779-7333,Fred.the.master@gmail.com,
    
    FasterCSV.foreach(filename) do |row|
      random_login = rand(9999).to_s
      if row[7]
        date_array = row[7].split("-")
        date = Time.parse("2000-#{date_array[1]}-#{date_array[0]}")
      else
        date = Time.now
      end
      User.create :family_name  => row[0],
                  :last_name    => row[1],
                  :middle_name  => row[2],
                  :first_name   => row[3],
                  :nationality  => row[4],
                  :family_role  => row[5],
                  :civil_state  => row[6],
                  :address1     => row[9],
                  :home_phone   => row[10],
                  :mobile_phone => row[11],
                  :email        => row[12],
                  :sacraments   => row[13],
                  :birthday     => date,
                  :login                  => random_login,
                  :password               => random_login,
                  :password_confirmation  => random_login
    end
    
  end

end
