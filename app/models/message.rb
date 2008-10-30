class Message < ActiveRecord::Base
  
  validates_presence_of :name
  
  after_create :deliver_notification
  
  def deliver_notification
    Notifications.deliver_new_message(self)
  end
  
  def self.new_messages_count
    self.count(:conditions => ["message_read = ?", false])
  end
    
end
