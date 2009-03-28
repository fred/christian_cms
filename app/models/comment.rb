class Comment < ActiveRecord::Base
  
  # Relationships
  belongs_to :article
  
end
