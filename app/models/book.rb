class Book < ActiveRecord::Base
  
  validates_presence_of :title
  validates_presence_of :author
  
  acts_as_ferret :fields => [ 'title', 'author', 'editorial', 'desc' ]
  
  def self.find_with_ferret_paginated(q,options = {})
     return nil if q.nil? or q==""
     results = self.find_id_by_contents(q)
     page ||= options[:page]
     per_page ||= options[:per_page]
     id_array = []
     results[1].each do |t|
       id_array << t[:id]
     end
     self.paginate id_array, :page => page, :per_page => per_page
  end
  
  def self.find_paginated(per_page, current_page, order_by)
    self.find(:all,
      :order => order_by, 
      :page => { :size => per_page, :current => current_page, :first => 1 }
    )
  end
  
end
