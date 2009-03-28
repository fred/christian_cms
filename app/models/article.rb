# +------------------+--------------+------+-----+---------+----------------+
# | Field            | Type         | Null | Key | Default | Extra          |
# +------------------+--------------+------+-----+---------+----------------+
# | id               | int(11)      | NO   | PRI | NULL    | auto_increment | 
# | user_id          | int(11)      | YES  |     | NULL    |                | 
# | title            | varchar(100) | YES  |     | NULL    |                | 
# | permalink        | varchar(50)  | YES  | UNI | NULL    |                | 
# | body             | text         | YES  |     | NULL    |                | 
# | published_at     | datetime     | YES  |     | NULL    |                | 
# | category         | varchar(30)  | YES  |     | NULL    |                | 
# | author           | varchar(30)  | YES  |     | NULL    |                | 
# | approved         | tinyint(1)   | YES  | MUL | 1       |                | 
# | created_at       | datetime     | YES  |     | NULL    |                | 
# | updated_at       | datetime     | YES  |     | NULL    |                | 
# | short_body       | text         | YES  |     | NULL    |                | 
# | expires_on       | datetime     | YES  |     | NULL    |                | 
# | protected_record | tinyint(1)   | YES  |     | 0       |                | 
# +------------------+--------------+------+-----+---------+----------------+
class Article < ActiveRecord::Base
  
  # Relationships
  belongs_to :user
  
  # Validations
  validates_presence_of :title
  validates_presence_of :short_body
  validates_uniqueness_of :title
  
  # Filters
  before_destroy :is_protected?
  after_save :sweep_partial_cache
  
  # Plugins
  has_permalink :title
  acts_as_taggable_on :tags
  ajaxful_rateable :stars => 5
  
  
  ### Methods ###
  
  # Last published date for an article
  def self.last_published_date
    Article.find(:first,
      :select => "id, published_at",
      :order => "published_at DESC"
    ).published_at
  end
  
  # Approved comments of an article
  def approved_comments
    Comment.find(
      :all, 
      :conditions => ["commentable_id = ? AND commentable_type = ? AND approved = 1", self.id, "Article"]
    )
  end
  
  def approved_comments_count
    Comment.count(
      :conditions => ["commentable_id = ? AND commentable_type = ? AND approved = 1", self.id, "Article"]
    )
  end
  
  # @article.add_rating(params[:rating].to_i, :ip => request.remote_ip)
  def add_rating(rating, ip)
    if Rating.find(:first, :conditions => ["ip = ? AND rateable_id = ?", ip, self.id])
      false
    else
      rating = Rating.new :rateable_id => self.id, 
        :ip => ip, 
        :rateable_type => self.class,
        :value => rating
      rating.save
    end
  end

  def set_permalink
    if self.permalink.to_s.empty?
      self.permalink = (self.published_at.strftime("%Y_%m_%d"))+"-"+permalink_for(self.title.to_s)
    end
  end
  
  def permalink_for(str)
    PermalinkFu.escape(str)
  end
  
  # Sphinx full text search
  def self.full_text_search(q, limit, order_by)
     return nil if q.nil? or q==""
     results = self.find_by_contents(q,
      :order => order_by, 
      :limit => limit
     )
     return results
  end
  
  def self.find_permalink(permalink)
    self.find(:first, :conditions => ["permalink = ? and approved = ? ", permalink, true])
  end
  
  def self.get_latest
    Article.find(:all, 
      :order => "created_at DESC", 
      :limit => 5,
      :conditions => ["articles.approved = ?", true]
    )
  end

  def self.get_articles
    Article.find(:all,
     :order => "published_at DESC",
     :limit => 5
    )
  end
  
  private
  
  # Protected articles cant be deleted
  def is_protected?
    if self.protected_record
      raise "Article is protected, You cannot delete it"
    else
      true
    end
  end
  
  # Sweep the fragments cache after an update
  def sweep_partial_cache
    cache_dir = RAILS_ROOT+"/tmp/cache/views/*"
    FileUtils.rm_r(Dir.glob(cache_dir)) rescue Errno::ENOENT
    logger.debug("Cache '#{cache_dir}' delete.")
  end
    
end
