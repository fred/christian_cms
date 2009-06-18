class Comment < ActiveRecord::Base
  
  # Relationships  
  belongs_to :article, :foreign_key => :commentable_id
  
end
