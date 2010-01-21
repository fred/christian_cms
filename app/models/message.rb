class Message < ActiveRecord::Base
  
  # author        : name submitted with the comment
  # author_url    : URL submitted with the comment
  # author_email  : email submitted with the comment
  # comment_type  : 'comment', 'trackback', 'pingback', or whatever you fancy
  # content       : the content submitted
  # permalink     : the permanent URL for the entry the comment belongs to
  # user_ip       : IP address used to submit this comment
  # user_agent    : user agent string
  # referrer      : http referer
  has_rakismet :author => :name, 
    :author_url => :website_url,
    :author_email => :email,
    :comment_type => "comment",
    :content => :body,
    :user_ip => :remote_ip
  
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
