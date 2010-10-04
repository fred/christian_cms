# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base
  
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
    :content => :comment,
    :user_ip => :remote_ip
  
  validates_presence_of :comment
  
  # Relationships  
  belongs_to :article, :foreign_key => :commentable_id
  
  before_save :check_spam
  
  def check_spam
    self.marked_spam = true if self.spam?
  end
  
end
