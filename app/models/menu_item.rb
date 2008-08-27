class MenuItem < ActiveRecord::Base
  MENU_TYPES = ["Link", "Menu", "Sidebar"]
  
  validates_presence_of :title
end
