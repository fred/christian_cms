class Rate < ActiveRecord::Base
  belongs_to :article
  belongs_to :rateable, :polymorphic => true
  
  attr_accessible :rate, :dimension
end
