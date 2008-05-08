class Article < ActiveRecord::Base
  
  acts_as_textiled :body, :short_body
  
  belongs_to :user
    
  validates_presence_of :title
  validates_presence_of :short_body
  validates_uniqueness_of :title
    
  has_permalink :title

  def set_permalink
    if self.permalink.to_s.empty?
      self.permalink = (self.published_at.strftime("%Y_%m_%d"))+"-"+permalink_for(self.title.to_s)
    end
  end
  
  def permalink_for(str)
    PermalinkFu.escape(str)
  end

  def self.find_with_ferret_paginated(q,options = {})
     return nil if q.nil? or q==""
     results = self.find_id_by_contents(q)
     page ||= options[:page]
     per_page ||= options[:per_page]
     id_array = []
     results[1].each do |t|
       id_array << t[:id]
     end
     self.paginate id_array, :page => page, :per_page => per_page, :order => "articles.id DESC"
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
  
  ### Callback to clean the cached pages ###
  after_save :sweep_partial_cache
  def sweep_partial_cache
    cache_dir = RAILS_ROOT+"/tmp/cache"
    cache_pages = cache_dir+"/*"
    FileUtils.rm_rf(Dir.glob(cache_pages)) rescue Errno::ENOENT
    RAILS_DEFAULT_LOGGER.info("Cache '#{cache_pages}' delete.")
  end
  
end
