class Admin::BaseController < ApplicationController
  
  before_filter :login_required
  before_filter :admin
  
  layout 'admin'
      
end
