class MenuItem < ActiveRecord::Base
  MENU_TYPES = ["Link", "Menu", "Sidebar"]
  
  validates_presence_of :title
  
  def self.menus
    find(:all, 
      :order => "display_order ASC", 
      :conditions => ["menu_type = ?", "Menu"]
    )
  end
    
  def self.links
    find(:all, 
      :order => "display_order ASC", 
      :conditions => ["menu_type = ?", "Link"]
    )
  end
  
  def self.sidebars
    find(:all, 
      :order => "display_order ASC", 
      :conditions => ["menu_type = ?", "Sidebar"]
    )
  end  
      
      
end
