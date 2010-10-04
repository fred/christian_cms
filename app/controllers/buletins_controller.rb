# -*- encoding : utf-8 -*-
class BuletinsController < ApplicationController
  
  # GET /articles
  # GET /articles.xml
  def index
    @buletin = Buletin.new
    if params[:sort]
      order = case params[:sort]
        when "title" then "title ASC, created_at ASC"
        when "file_name"  then "filename ASC"
        when "date"  then "created_at DESC"
      end
    else
      order = "created_at DESC"
    end
    per_page = 40
    current_page = (params[:page] ||= 1).to_i
    @buletins = Buletin.paginate :page => current_page, :per_page => per_page, :order => order
    
  end
  
end
