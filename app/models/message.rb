class Message < ActiveRecord::Base
  
  validates_presence_of :name
  
  after_save :deliver_notification
  
  def deliver_notification
    Notifications.deliver_new_message(self)
  end
    
end
