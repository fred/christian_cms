class UserIcon < ActiveRecord::Base
  
  belongs_to :user
  
  before_save :clear_old

  has_attachment  :storage => :file_system, 
                  :path_prefix => 'public/files',
                  :content_type => :image,
                  :thumbnails => { :thumb => [128, 128] }

  
  protected
  def clear_old
    icons = UserIcon.find(:all, :conditions => ["user_id = ?", self.user_id])
    icons.each do |t|
      t.destroy
    end
  end
end

