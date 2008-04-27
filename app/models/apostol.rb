class Apostol < ActiveRecord::Base
  
  belongs_to :bible
  has_many :bible_texts 
  
end
