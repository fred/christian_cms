class EventsController < ApplicationController

  # GET /events
  # GET /events.xml
  def index
    if params[:sort]
      order = case params[:sort]
        when "title" then "title ASC"
        when "start_date"  then "start_date DESC"
      end
    else
      order = "start_date DESC"
    end
    per_page = 10
    current_page = (params[:page] ||= 1).to_i

    @events = Event.paginate :page => current_page, :per_page => per_page, :order => order
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end
  
  def search
    if params[:search_event] && params[:search_event][:q] != ""
      limit = 20
      order = "title ASC"
      @events = Event.full_text_search(params[:search_event][:q], limit, order)
    else
      @events = []
      flash[:notice] = 'No fue encrontrado nada con esta criteria.'
    end
  end


  # GET /events/1
  # GET /events/1.xml
  def show
    if params[:id]
      @event = Event.find(params[:id])
    else
      @event = Event.find_permalink(params[:permalink])
    end
    @meta_title = @event.title 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

end
