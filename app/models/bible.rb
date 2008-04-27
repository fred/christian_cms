class Bible < ActiveRecord::Base
  
  has_many :apostols
  has_many :bible_texts, :through => :apostols
  
end
