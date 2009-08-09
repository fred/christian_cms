class Message < ActiveRecord::Base
  
  # Validations
  validates_presence_of :name
  validates_presence_of :body
  validates_presence_of :email
  
  # Filters
  after_create :deliver_notification
  
  ### Methods ### 
  
  def deliver_notification
    Notifications.deliver_new_message(self)
  end
  
  def self.new_messages_count
    self.count(:conditions => ["message_read = ?", false])
  end
    
end
