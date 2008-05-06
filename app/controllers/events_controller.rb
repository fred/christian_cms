class EventsController < ApplicationController
  
  before_filter :admin, :except => [ :index, :list, :show, :search ]

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
    @meta_title = @meta_title + " - " + @event.title 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event_status = ["Confirmed", "Not Confirmed"]
    @priorities = ["Normal", "Important", "Very Important"]
    @event = Event.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event_status = ["Confirmed", "Not Confirmed"]
    @priorities = ["Normal", "Important", "Very Important"]
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event_status = ["Confirmed", "Not Confirmed"]
    @priorities = ["Normal", "Important", "Very Important"]
    @event = Event.new(params[:event])
    respond_to do |format|
      if @event.save
        flash[:notice] = 'Evento fue creado con sucesso.'
        format.html { redirect_to events_path }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Evento fue salvo con sucesso.'
        format.html { redirect_to events_path }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to("/") }
      format.xml  { head :ok }
    end
  end
  
  
end
