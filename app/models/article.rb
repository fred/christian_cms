class Article < ActiveRecord::Base
  
  acts_as_textiled :body, :short_body

  belongs_to :user
    
  validates_presence_of :title
  validates_presence_of :short_body
  validates_uniqueness_of :title
  
  has_permalink :title
  
  define_index do
    indexes title
    indexes short_body
    indexes body
    indexes approved
    has published_at
  end
  

  def set_permalink
    if self.permalink.to_s.empty?
      self.permalink = (self.published_at.strftime("%Y_%m_%d"))+"-"+permalink_for(self.title.to_s)
    end
  end
  
  def permalink_for(str)
    PermalinkFu.escape(str)
  end
  
  def self.full_text_search(q, limit, order_by)
     return nil if q.nil? or q==""
     results = self.find_by_contents(q,
      :order => order_by, 
      :limit => limit
     )
     return results
  end
  
  def self.find_permalink(permalink)
    self.find(:first, :conditions => ["permalink = ?", permalink])
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
     :conditions =>  ["category = 'articulo'"], 
     :order => "created_at DESC",
     :limit => 5
    )
  end
  
  before_destroy :is_protected?
  after_save :sweep_partial_cache
  
  private
  
  def is_protected?
    if self.protected_record
      raise "Article is protected, You cannot delete it"
    else
      true
    end
  end
  
  def sweep_partial_cache
    cache_dir = RAILS_ROOT+"/tmp/cache/views/*"
    FileUtils.rm_r(Dir.glob(cache_dir)) rescue Errno::ENOENT
    logger.debug("Cache '#{cache_dir}' delete.")
  end
    
end
