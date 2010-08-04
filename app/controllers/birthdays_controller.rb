class BirthdaysController < ApplicationController

  def index
    if params[:sort]
      order = case params[:sort]
        when "first_name" then "first_name ASC, last_name ASC, month(birthdate) ASC, day(birthdate) ASC"
        when "last_name"  then "last_name ASC, first_name ASC, month(birthdate) ASC, day(birthdate) ASC"
        when "birthdate"  then "month(birthdate) ASC, day(birthdate) ASC, last_name ASC, first_name ASC"
      end
    else
      order = "month(birthdate) ASC, day(birthdate) ASC"
    end
    per_page = 36
    current_page = (params[:page] ||= 1).to_i
    
    if params[:month]
      @month = params[:month]
      @birthdays = Birthday.get_by_month(params[:month])
    else
      @month = ""
      @birthdays = Birthday.paginate :page => current_page, :per_page => per_page, :order => order
    end

  end
    
end
