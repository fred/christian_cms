# -*- encoding : utf-8 -*-
class MessagesController < ApplicationController
  
  def index
    redirect_to :action => "new"
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end
  
  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    
    @message.remote_ip = request.remote_ip
    @message.referrer  = request.referrer
    @message.user_agent = request.env["HTTP_USER_AGENT"]

    if logged_in?
      @message.user_id = current_user.id
    end
    # 
    # if @message.spam?
    #    @message.marked_spam = true 
    #    logger.warn "Contact Message marked as spam. Akismet Response: #{@message.akismet_response}"
    # end

    respond_to do |format|
      if @message.save
        flash[:success] = 'Mensaje fue enviado con suceso.'
        format.html { redirect_to :action => "thank_you" }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end
    
  def thank_you
  end
  
end
