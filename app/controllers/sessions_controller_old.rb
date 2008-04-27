# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  def show
    redirect_to "/"
  end
  
  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      if self.current_user.admin
        redirect_to( "/")
      else
        redirect_to( :controller => "users", :action => "edit")
      end
      flash[:notice] = "Logged in successfully"
    else
      flash[:notice] = "Incorrect Login"
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    User.current_user = nil
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default("/")
  end
end
