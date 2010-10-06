# -*- encoding : utf-8 -*-
class Admin::BaseController < ApplicationController
  
  before_filter :admin_login_required
  
  layout 'admin'
      
end
