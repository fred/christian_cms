require 'digest/sha1'
class User < ActiveRecord::Base
  
  HUMANIZED_ATTRIBUTES = {
    :email => "E-mail address",
    :password => "Contraseña",
    :first_name => "Nombre",
    :last_name => "Appellido"
  }
  
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login, :email, :first_name
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  before_save :encrypt_password
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, 
    :first_name, :middle_name, :last_name, :family_name, :full_name, :display_name,
    :mobile_phone, :home_phone, :office_phone, :address1, :address2, :city, :country,
    :nationality, :birthday, :display_address, :display_name, 
    :family_role, :civil_state, :sacraments
  
  #apply_simple_captcha
  has_many :articles
  cattr_accessor :current_user
  

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
  
  
  def self.find_paginated(per_page, current_page, order_by)
    if authorized_admin?
      self.find(:all,
        :order => order_by,
        :page => { :size => per_page, :current => current_page, :first => 1 }
      )
    else
      self.find(:all,
        :order => order_by, 
        :conditions => ["approved = 1"],
        :page => { :size => per_page, :current => current_page, :first => 1 }
      )
    end
  end
  
  def self.find_with_ferret_paginated(q,options = {})
     return nil if q.nil? or q==""
     results = self.find_id_by_contents(q)
     page ||= options[:page]
     per_page ||= options[:per_page]
     id_array = []
     results[1].each do |t|
       id_array << t[:id]
     end
     self.paginate id_array, 
      :page => page, 
      :per_page => per_page
  end

  def self.full_text_search(q, limit, order_by)
    return nil if q.nil? or q==""
    results = self.find_by_contents(q,
      :order => order_by, 
      :limit => limit
    )
    public_users = results.find_all {|t| t.approved == true }
    if authorized_admin?
      return results
    else
      return public_users
    end
  end
  

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
    
end
