# -*- encoding : utf-8 -*-
class Admin::EventsController < Admin::BaseController
  
  # GET /events
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
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = 'Evento fue creado con sucesso.'
      redirect_to :action => "index" 
    else
      render :action => "new"
    end
  end

  # PUT /events/1
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Evento fue salvo con sucesso.'
      redirect_to :action => "edit", :id => @event.id
    else
      render :action => "edit"
    end
  end

  # DELETE /events/1
  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:notice] = 'Evento no fue deletado sucesso.'
    end
    redirect_to :action => "index"
  end
  
  
end
