# +------------+-------------+------+-----+---------+----------------+
# | Field      | Type        | Null | Key | Default | Extra          |
# +------------+-------------+------+-----+---------+----------------+
# | id         | int(11)     | NO   | PRI | NULL    | auto_increment | 
# | name       | varchar(40) | YES  |     | NULL    |                | 
# | email      | varchar(40) | YES  |     | NULL    |                | 
# | website    | varchar(40) | YES  |     | NULL    |                | 
# | body       | text        | YES  |     | NULL    |                | 
# | approved   | tinyint(1)  | YES  |     | 0       |                | 
# | created_at | datetime    | YES  |     | NULL    |                | 
# | updated_at | datetime    | YES  |     | NULL    |                | 
# +------------+-------------+------+-----+---------+----------------+

class Comment < ActiveRecord::Base
  
  belongs_to :article
  #validates_presence_of :name, :message

end
