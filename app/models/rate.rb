class Rate < ActiveRecord::Base

  # Relationships
  belongs_to :user
  belongs_to :rateable, :polymorphic => true
  
  attr_accessible :rate
  
end
