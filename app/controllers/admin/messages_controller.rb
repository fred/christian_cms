class Admin::MessagesController < Admin::BaseController
  
  # GET /messages
  # GET /messages.xml
  def index
    @messages = Message.find(:all)
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])
    # udpate unread message to read
    if !@message.message_read
      @message.update_attributes(:message_read => true)
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      flash[:notice] = 'Message was successfully updated.'
      redirect_to(:action => "index")
    else
      render :action => "edit"
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to(:action => "index")
  end
  
end
